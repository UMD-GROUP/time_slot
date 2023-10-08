import 'package:time_slot/utils/tools/file_importers.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc() : super(PurchaseState(status: ResponseStatus.pure)) {
    on<PurchaseEvent>((event, emit) {});
    on<GetPurchasesEvent>(getPurchases);
    on<AddPurchaseEvent>(addPurchase);
  }

  Future<void> getPurchases(GetPurchasesEvent event, Emitter emit) async {
    emit(state.copyWith(status: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<PurchaseRepository>().getPurchases();
    if (myResponse.statusCode! == 200) {
      emit(state.copyWith(
          orders: myResponse.data, status: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
        status: ResponseStatus.inFail,
      ));
    }
  }

  Future<void> addPurchase(AddPurchaseEvent event, Emitter emit) async {
    if (event.purchase.amount < 50000) {}
    emit(state.copyWith(addingStatus: ResponseStatus.inProgress));
    final MyResponse myResponse = await getIt<PurchaseRepository>()
        .addPurchase(event.purchase, event.user);
    if (myResponse.statusCode! == 200) {
      emit(state.copyWith(addingStatus: ResponseStatus.inSuccess));
      add(GetPurchasesEvent());
    } else {
      emit(state.copyWith(
          addingStatus: ResponseStatus.inFail, message: myResponse.message));
    }
    emit(state.copyWith(addingStatus: ResponseStatus.pure));
  }
}
