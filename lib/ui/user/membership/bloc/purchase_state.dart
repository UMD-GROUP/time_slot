part of 'purchase_bloc.dart';

@immutable
class PurchaseState extends Equatable {
  PurchaseState({
    required this.status,
    this.addingStatus = ResponseStatus.pure,
    this.message = '',
    this.orders,
  });
  ResponseStatus status;
  List? orders;
  ResponseStatus addingStatus;
  String message;

  PurchaseState copyWith({
    ResponseStatus? status,
    List? orders,
    ResponseStatus? addingStatus,
    String? message,
  }) =>
      PurchaseState(
          addingStatus: addingStatus ?? this.addingStatus,
          message: message ?? this.message,
          orders: orders ?? this.orders,
          status: status ?? this.status);

  @override
  // TODO: implement props
  List<Object?> get props => [orders, status, addingStatus, message];
}
