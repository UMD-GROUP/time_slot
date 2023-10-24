import 'package:time_slot/ui/admin/admin_home/data/models/reserve_model.dart';
import 'package:time_slot/ui/admin/admin_home/data/repository/reserve_repository.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

part 'reserve_event.dart';
part 'reserve_state.dart';

class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  ReserveBloc() : super(ReserveState(reserves: const [])) {
    on<GetAllReservesEvent>(getAllReserves);
    on<CreateTheReserveEvent>(createTheReserve);
    on<UpdateTheReserveEvent>(updateTheReserve);
    on<DeleteTheReserveEvent>(deleteTheReserve);
    on<ChangeCurrentReserveEvent>(changeCurrentReserve);
  }

  Future<void> getAllReserves(GetAllReservesEvent event, Emitter emit) async {
    if (state.gettingStatus == ResponseStatus.pure) {
      emit(state.copyWith(status: ResponseStatus.inProgress));
    }
    final MyResponse myResponse =
        await getIt<ReserveRepository>().getAllReserves();
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(
          status: ResponseStatus.inSuccess, reserves: myResponse.data));
    } else {
      emit(state.copyWith(
          status: ResponseStatus.inFail, message: myResponse.message));
    }
  }

  Future<void> createTheReserve(
      CreateTheReserveEvent event, Emitter emit) async {
    emit(state.copyWith(creatingStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<ReserveRepository>().createReserve(event.reserve);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(creatingStatus: ResponseStatus.inSuccess));
      add(GetAllReservesEvent());
    } else {
      emit(state.copyWith(
          creatingStatus: ResponseStatus.inFail, message: myResponse.message));
    }
    emit(state.copyWith(creatingStatus: ResponseStatus.pure));
  }

  Future<void> deleteTheReserve(
      DeleteTheReserveEvent event, Emitter emit) async {
    emit(state.copyWith(deletingStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<ReserveRepository>().deleteReserve(event.docId);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(deletingStatus: ResponseStatus.inSuccess));
    } else {
      state.reserves.removeWhere((element) => element.docId == event.docId);
      emit(state.copyWith(
          deletingStatus: ResponseStatus.inFail,
          message: myResponse.message,
          reserves: state.reserves));
    }
    emit(state.copyWith(deletingStatus: ResponseStatus.pure));
  }

  Future<void> updateTheReserve(
      UpdateTheReserveEvent event, Emitter emit) async {
    emit(state.copyWith(updatingStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<ReserveRepository>().updateReserve(event.reserve);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(updatingStatus: ResponseStatus.inSuccess));
      add(GetAllReservesEvent());
    } else {
      emit(state.copyWith(
          updatingStatus: ResponseStatus.inFail, message: myResponse.message));
    }
    emit(state.copyWith(updatingStatus: ResponseStatus.pure));
  }

  Future<void> changeCurrentReserve(
      ChangeCurrentReserveEvent event, Emitter emit) async {
    late ReserveModel reserve;
    final List reserves = state.reserves
        .where((element) => element.date.isAtSameMomentAs(event.day))
        .toList();
    if (reserves.isNotEmpty) {
      reserve = reserves.first;
    } else {
      reserve = ReserveModel(date: event.day);
    }
    emit(state.copyWith(currentReserve: reserve));
  }
}
