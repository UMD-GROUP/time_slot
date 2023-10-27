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
    if (!event.order.reserve.isNull && !event.freeLimit.isNull) {
      event.order = calculateSum(event.order, event.freeLimit!);
    }
    emit(state.copyWith(newOrder: event.order, isUpdated: !state.isUpdated));
  }

  OrderModel calculateSum(OrderModel order, int freeLimit) {
    int sum = 0;
    final int productCount =
        order.products.fold(0, (i, e) => int.parse((i + e.count).toString()));
    sum += (productCount >= freeLimit ? productCount - freeLimit : 0) *
        order.reserve!.price;
    order.sum = sum;
    if (!order.promoCode.isNull && order.promoCode!.minAmount <= productCount) {
      sum -= (sum / 100 * order.promoCode!.discount).toInt();
    }
    order.totalSum = sum;
    if (freeLimit >= productCount) {
      order.freeLimit = productCount;
    } else {
      order.freeLimit = freeLimit;
    }

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
