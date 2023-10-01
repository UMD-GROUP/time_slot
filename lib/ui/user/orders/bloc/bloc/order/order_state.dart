part of 'order_bloc.dart';

@immutable
class OrderState extends Equatable {
  OrderState({
   required this.status,
   this.orders,
   required this.index
  });
  ResponseStatus status;
  List? orders;
  int index;

  OrderState copyWith(
      {ResponseStatus? status,
        List? orders,
        int? index
        }) =>
      OrderState(
          index: index ?? this.index,
          orders: orders ?? this.orders,
          status: status ?? this.status);

  @override
  // TODO: implement props
  List<Object?> get props => [status,orders,index];

}


