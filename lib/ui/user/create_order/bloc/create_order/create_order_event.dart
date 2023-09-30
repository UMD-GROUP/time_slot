part of 'create_order_bloc.dart';

@immutable
abstract class CreateOrderEvent {}

class UpdateFieldsOrderEvent extends CreateOrderEvent {
  UpdateFieldsOrderEvent(this.order);
  OrderModel order;
}
