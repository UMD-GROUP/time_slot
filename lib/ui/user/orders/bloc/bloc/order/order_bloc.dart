// ignore_for_file: cascade_invocations, avoid_catches_without_on_clauses

import 'dart:async';

import '../../../../../../utils/tools/file_importers.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState(status: ResponseStatus.pure, index: 0)) {
    on<OrderEvent>((event, emit) {});
    on<GetOrderEvent>(getOrders);
  }

  Future<void> getOrders(GetOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: ResponseStatus.inProgress));
    try {
      await for (final orders in getIt<OrdersRepository>().getOrdersStream()) {
        emit(state.copyWith(orders: orders, status: ResponseStatus.inSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: ResponseStatus.inFail));
    }
  }
}
