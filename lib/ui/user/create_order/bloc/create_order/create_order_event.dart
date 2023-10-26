part of 'create_order_bloc.dart';

@immutable
abstract class CreateOrderEvent {}

class UpdateFieldsOrderEvent extends CreateOrderEvent {
  UpdateFieldsOrderEvent(this.order, {this.freeLimit});
  OrderModel order;
  int? freeLimit;
}

class AddOrderEvent extends CreateOrderEvent {
  AddOrderEvent(this.order, this.user);
  OrderModel order;
  UserModel user;
}

class ReInitOrderEvent extends CreateOrderEvent {}
