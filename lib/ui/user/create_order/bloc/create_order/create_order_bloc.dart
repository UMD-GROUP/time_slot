import 'package:time_slot/utils/tools/file_importers.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc()
      : super(CreateOrderState(OrderModel(
            finishedAt: DateTime.now(),
            createdAt: DateTime.now(),
            date: DateTime(2021, 12, 12),
            products: [],
            orderId: generateRandomID(true)))) {
    on<UpdateFieldsOrderEvent>(updateFields);
    on<AddOrderEvent>(addOrder);
    on<ReInitOrderEvent>(initOrder);
  }

  void updateFields(UpdateFieldsOrderEvent event, Emitter emit) {
    event.order = calculateSum(event.order, event.freeLimit, event.minAmount);
    emit(state.copyWith(newOrder: event.order, isUpdated: !state.isUpdated));
  }

  OrderModel calculateSum(OrderModel order, int? freeLimit1, int minAmount) {
    int sum = 0;
    int totalSum = 0;
    final int price = order.reserve.isNull ? 0 : order.reserve!.price;
    final int freeLimit = freeLimit1 ?? 0;
    final int allProductsCount =
        order.products.fold(0, (i, e) => int.parse((i + e.count).toString()));
    final int paidProductsCount =
        allProductsCount > freeLimit ? allProductsCount - freeLimit : 0;
    sum += paidProductsCount * price;
    totalSum += paidProductsCount * price;
    double discount = 0;
    order.freeLimit =
        allProductsCount > freeLimit ? freeLimit : allProductsCount;

    if (!order.promoCode.isNull &&
        order.promoCode!.minAmount <= allProductsCount) {
      totalSum -= (totalSum / 100 * order.promoCode!.discount).toInt();
    } else if (paidProductsCount >= 100 && paidProductsCount <= 199) {
      discount = 0.1;
    } else if (paidProductsCount > 199 && paidProductsCount <= 499) {
      discount = 0.15;
    } else if (paidProductsCount >= 500 && paidProductsCount <= 999) {
      discount = 0.2;
    } else if (paidProductsCount >= 1000 && paidProductsCount <= 1999) {
      discount = 0.25;
    } else if (paidProductsCount >= 2000) {
      discount = 0.3;
    }

    totalSum = totalSum - (sum * discount).toInt();
    order.discountUsed = discount != 0.0;

    if (!order.discountUsed && order.promoCode.isNull) {
      if (sum < minAmount && paidProductsCount > 0) {
        sum = minAmount;
        totalSum = minAmount;
      }
    }

    order
      ..sum = sum - sum % 1000
      ..totalSum = totalSum - totalSum % 1000;
    print(
        'MANA SUM -> ${order.sum} -> ${totalSum}  Discount->  $discount, PaidProductsCount -> $paidProductsCount, ProductsCount-> $allProductsCount, FreeLimits $freeLimit');

    return order;
  }

  Future<void> addOrder(AddOrderEvent event, Emitter emit) async {
    emit(state.copyWith(addingStatus: ResponseStatus.inProgress));
    if (orderValidator(event.order).isEmpty) {
      final MyResponse myResponse = await getIt<CreateOrderRepository>()
          .addOrder(event.order, event.user);
      if (!myResponse.message.isNull) {
        emit(state.copyWith(
            addingStatus: ResponseStatus.inFail, message: myResponse.message));
      } else {
        emit(state.copyWith(
            addingStatus: ResponseStatus.inSuccess,
            newOrder: OrderModel(
                finishedAt: DateTime.now(),
                createdAt: DateTime.now(),
                products: [],
                date: DateTime.now())));
      }
    } else {
      emit(state.copyWith(
          addingStatus: ResponseStatus.inFail,
          message: orderValidator(event.order)));
    }
    emit(state.copyWith(addingStatus: ResponseStatus.pure));
  }

  void initOrder(ReInitOrderEvent event, Emitter emit) {
    emit(CreateOrderState(OrderModel(
        products: [],
        date: DateTime(2021, 12, 12),
        createdAt: DateTime.now(),
        finishedAt: DateTime.now())));
  }
}
