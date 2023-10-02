part of 'purchase_bloc.dart';

@immutable
class PurchaseState extends Equatable{
  PurchaseState({
    required this.status,
    this.orders,
  });
  ResponseStatus status;
  List? orders;


  PurchaseState copyWith(
      {ResponseStatus? status,
        List? orders,
      }) =>
      PurchaseState(
          orders: orders ?? this.orders,
          status: status ?? this.status);

  @override
  // TODO: implement props
  List<Object?> get props => [orders,status];

}

