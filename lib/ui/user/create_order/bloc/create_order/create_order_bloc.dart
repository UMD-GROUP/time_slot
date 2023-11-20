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
    final int price = order.reserve.isNull ? 0 : order.reserve!.price;
    final int freeLimit = freeLimit1 ?? 0;
    final int productCount =
        order.products.fold(0, (i, e) => int.parse((i + e.count).toString()));
    sum += (productCount >= freeLimit ? productCount - freeLimit : 0) * price;
    print(
        'Sum -> $sum , freeLimit -> $freeLimit1, productsCount -> $productCount');

    order.sum = sum;
    double discount = 0;

    if (freeLimit >= productCount) {
      order.freeLimit = productCount;
    } else {
      order.freeLimit = freeLimit;
    }

    final int discountProductsCount = productCount - freeLimit;

    if (!order.promoCode.isNull && order.promoCode!.minAmount <= productCount) {
      sum -= (sum / 100 * order.promoCode!.discount).toInt();
    } else if (order.totalSum >= 10000) {
      if (discountProductsCount >= 100 && discountProductsCount <= 199) {
        discount = 0.1;
      } else if (discountProductsCount >= 200 && discountProductsCount <= 499) {
        discount = 0.15;
      } else if (discountProductsCount >= 500 && discountProductsCount <= 999) {
        discount = 0.2;
      } else if (discountProductsCount >= 1000 &&
          discountProductsCount <= 1999) {
        discount = 0.25;
      } else if (discountProductsCount >= 2000) {
        discount = 0.3;
      }
    }
    if (discount != 0 && sum > 10000) {
      order.sum = sum;
      sum = sum - (sum * discount).toInt();
      order.discountUsed = true;
      if (sum == 0) {
        order.totalSum = 10000;
      }
    } else {
      order.discountUsed = false;
    }

    if (order.sum < minAmount || order.totalSum < minAmount) {
      sum = minAmount;
      order
        ..totalSum = minAmount
        ..sum = minAmount;
    }

    order.totalSum = sum - sum % 1000;
    print('MANA SUM -> ${order.sum} -> ${order.totalSum}');

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
