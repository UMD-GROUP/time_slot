part of 'create_order_bloc.dart';

@immutable
class CreateOrderState extends Equatable {
  CreateOrderState(this.order, {this.isUpdated = false});
  OrderModel order;
  bool isUpdated;

  CreateOrderState copyWith({OrderModel? newOrder, bool? isUpdated}) =>
      CreateOrderState(newOrder ?? order,
          isUpdated: isUpdated ?? this.isUpdated);
  @override
  List<Object?> get props => [order];
}
