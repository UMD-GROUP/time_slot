import 'package:time_slot/utils/tools/file_importers.dart';
part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc() : super(PurchaseState(status: ResponseStatus.pure)) {
    on<PurchaseEvent>((event, emit) {});
    on<GetPurchasesEvent>(gePurchases);
  }


  Future<void> gePurchases(GetPurchasesEvent event, Emitter emit) async {
    emit(state.copyWith(status: ResponseStatus.inProgress));
    final MyResponse myResponse = await getIt<PurchaseRepository>().getPurchases();
    if (myResponse.statusCode! == 200) {
      emit(state.copyWith(
          orders: myResponse.data, status: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(status: ResponseStatus.inFail,));
    }
  }


}
