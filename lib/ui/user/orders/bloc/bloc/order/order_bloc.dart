import 'package:time_slot/ui/user/orders/data/repository/orders_repository.dart';
import '../../../../../../utils/tools/file_importers.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState(status: ResponseStatus.pure, index: 0)) {
    on<OrderEvent>((event, emit) {});
    on<GetOrderEvent>(geOrders);
  }


  Future<void> geOrders(GetOrderEvent event, Emitter emit) async {
    emit(state.copyWith(status: ResponseStatus.inProgress));
    final MyResponse myResponse = await getIt<OrdersRepository>().getOrders();
    if (myResponse.statusCode! == 200) {
      emit(state.copyWith(
          orders: myResponse.data, status: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(status: ResponseStatus.inFail,));
    }
  }

}
