import 'package:time_slot/utils/tools/file_importers.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc() : super(CreateOrderState(OrderModel(dates: []))) {
    on<UpdateFieldsOrderEvent>(updateFields);
  }

  void updateFields(UpdateFieldsOrderEvent event, Emitter emit) {
    emit(state.copyWith(newOrder: event.order, isUpdated: !state.isUpdated));
  }
}
