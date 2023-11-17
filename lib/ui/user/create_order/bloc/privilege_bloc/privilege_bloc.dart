// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:scrollable_clean_calendar/utils/extensions.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

part 'privilege_event.dart';
part 'privilege_state.dart';

class PrivilegeBloc extends Bloc<PrivilegeEvent, PrivilegeState> {
  PrivilegeBloc() : super(PrivilegeState()) {
    on<GetTheReverseEvent>(getAllReserves);
    on<GetThePromoCodeEvent>(getThePromoCode);
  }

  Future<void> getAllReserves(GetTheReverseEvent event, Emitter emit) async {
    emit(state.copyWith(reservesStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<ReserveRepository>().getAllReserves();
    if (myResponse.statusCode == 200) {
      emitTheReverse(myResponse.data, event.day, emit);
    } else {
      emit(state.copyWith(
          reservesStatus: ResponseStatus.inFail, message: myResponse.message));
    }
  }

  void emitTheReverse(
      List<ReserveModel> reserves, DateTime? day, Emitter emit) {
    late ReserveModel reserve;
    final List filteredReserves = reserves
        .where((element) => element.date
            .isSameDay(day ?? DateTime.now().add(const Duration(days: 2))))
        .toList();
    if (filteredReserves.isNotEmpty) {
      reserve = filteredReserves.first;
    } else {
      reserve = ReserveModel(
          date: day ?? DateTime.now().add(const Duration(days: 2)));
    }
    emit(state.copyWith(
        reservesStatus: ResponseStatus.inSuccess, reserve: reserve));
  }

  Future<void> getThePromoCode(GetThePromoCodeEvent event, Emitter emit) async {
    emit(state.copyWith(promoCodeStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<PromoCodesRepository>().getThePromoCode(event.promoCode);
    if (myResponse.statusCode == 200) {
      final PromoCodeModel promoCodeModel = myResponse.data;
      if (promoCodeModel.maxUsingLimit == promoCodeModel.usedOrders.length) {
        emit(state.copyWith(
            promoCodeStatus: ResponseStatus.inFail,
            message: 'promo_code_expired'.tr));
        return;
      }

      emit(state.copyWith(
          promoCodeStatus: ResponseStatus.inSuccess,
          promoCode: myResponse.data));
    } else {
      print(myResponse.message);

      emit(state.copyWith(
          promoCodeStatus: ResponseStatus.inFail, message: myResponse.message));
    }
    emit(state.copyWith(promoCodeStatus: ResponseStatus.pure));
  }
}
