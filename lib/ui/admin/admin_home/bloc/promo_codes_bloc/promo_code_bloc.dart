import 'package:time_slot/utils/tools/file_importers.dart';

part 'promo_code_event.dart';
part 'promo_code_state.dart';

class PromoCodeBloc extends Bloc<PromoCodeEvent, PromoCodeState> {
  PromoCodeBloc() : super(PromoCodeState(promoCodes: const [])) {
    on<GetPromoCodesEvent>(getPromoCodes);
    on<CreateNewCodeEvent>(createPromoCode);
    on<DeleteCodeEvent>(deletePromoCode);
  }

  Future<void> getPromoCodes(GetPromoCodesEvent event, Emitter emit) async {
    if (state.gettingStatus == ResponseStatus.pure) {
      emit(state.copyWith(gettingStatus: ResponseStatus.inProgress));
    }
    final MyResponse myResponse =
        await getIt<PromoCodesRepository>().getPromoCodes();
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(
          gettingStatus: ResponseStatus.inSuccess,
          promoCodes: myResponse.data));
    } else {
      emit(state.copyWith(
          gettingStatus: ResponseStatus.inFail, message: myResponse.message));
    }
  }

  Future<void> createPromoCode(CreateNewCodeEvent event, Emitter emit) async {
    emit(state.copyWith(creatingStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<PromoCodesRepository>().addPromoCode(event.promoCode);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(creatingStatus: ResponseStatus.inSuccess));
      add(GetPromoCodesEvent());
    } else {
      emit(state.copyWith(
          creatingStatus: ResponseStatus.inFail, message: myResponse.message));
    }
    emit(state.copyWith(creatingStatus: ResponseStatus.pure));
  }

  Future<void> deletePromoCode(DeleteCodeEvent event, Emitter emit) async {
    emit(state.copyWith(deletingStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<PromoCodesRepository>().deletePromoCode(event.docId);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(deletingStatus: ResponseStatus.inSuccess));
    } else {
      state.promoCodes.removeWhere((element) => element.docId == event.docId);
      emit(state.copyWith(
          deletingStatus: ResponseStatus.inFail,
          message: myResponse.message,
          promoCodes: state.promoCodes));
    }
    emit(state.copyWith(deletingStatus: ResponseStatus.pure));
  }
}
