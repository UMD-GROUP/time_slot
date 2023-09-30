part of 'create_order_bloc.dart';

@immutable
class CreateOrderState extends Equatable {
  CreateOrderState(this.order,
      {this.message = '',
      this.isUpdated = false,
      this.addingStatus = ResponseStatus.pure});
  OrderModel order;
  bool isUpdated;
  ResponseStatus addingStatus;
  String message;

  CreateOrderState copyWith({
    OrderModel? newOrder,
    bool? isUpdated,
    ResponseStatus? addingStatus,
    String? message,
  }) =>
      CreateOrderState(newOrder ?? order,
          message: message ?? this.message,
          addingStatus: addingStatus ?? this.addingStatus,
          isUpdated: isUpdated ?? this.isUpdated);
  @override
  List<Object?> get props => [order, isUpdated, message, addingStatus];
}
