import 'package:time_slot/ui/admin/admin_home/data/repository/stores_repository.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

part 'stores_event.dart';
part 'stores_state.dart';

class StoresBloc extends Bloc<StoresEvent, StoresState> {
  StoresBloc() : super(StoresState(stores: const [])) {
    on<GetStoresEvent>(getStores);
    on<UpdateStoreEvent>(updateTheStore);
    on<DeleteStoreEvent>(deleteTheStore);
  }
  Future<void> getStores(GetStoresEvent event, Emitter emit) async {
    emit(state.copyWith(gettingStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<StoresRepository>().getStores(event.ownerId);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(
          gettingStatus: ResponseStatus.inSuccess, stores: myResponse.data));
    } else {
      emit(state.copyWith(
          gettingStatus: ResponseStatus.inFail, message: myResponse.message));
    }
  }

  Future<void> updateTheStore(UpdateStoreEvent event, Emitter emit) async {
    emit(state.copyWith(updatingStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<StoresRepository>().updateStore(event.store);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(updatingStatus: ResponseStatus.inSuccess));
      add(GetStoresEvent(event.store.ownerDoc));
    } else {
      emit(state.copyWith(
          updatingStatus: ResponseStatus.inFail, message: myResponse.message));
    }
    emit(state.copyWith(updatingStatus: ResponseStatus.pure));
  }

  Future<void> deleteTheStore(DeleteStoreEvent event, Emitter emit) async {
    emit(state.copyWith(deletingStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<StoresRepository>().deleteStore(event.docId);
    if (myResponse.statusCode == 200) {
      state.stores.removeWhere((element) => element.storeDocId == event.docId);
      emit(state.copyWith(
          deletingStatus: ResponseStatus.inSuccess, stores: state.stores));
    } else {
      emit(state.copyWith(
          deletingStatus: ResponseStatus.inFail, message: myResponse.message));
    }
    emit(state.copyWith(deletingStatus: ResponseStatus.pure));
  }
}
