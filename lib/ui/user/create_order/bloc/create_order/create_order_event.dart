part of 'create_order_bloc.dart';

@immutable
abstract class CreateOrderEvent {}

class UpdateFieldsOrderEvent extends CreateOrderEvent {
  UpdateFieldsOrderEvent(this.order, this.minAmount, {this.freeLimit});
  OrderModel order;
  int? freeLimit;
  int minAmount;
}

class AddOrderEvent extends CreateOrderEvent {
  AddOrderEvent(this.order, this.user);
  OrderModel order;
  UserModel user;
}

class ReInitOrderEvent extends CreateOrderEvent {}
