part of 'create_order_bloc.dart';

@immutable
abstract class CreateOrderEvent {}

class UpdateFieldsOrderEvent extends CreateOrderEvent {
  UpdateFieldsOrderEvent(this.order);
  OrderModel order;
}

class AddOrderEvent extends CreateOrderEvent {
  AddOrderEvent(this.order, this.user);
  OrderModel order;
  UserModel user;
}
