import 'package:time_slot/ui/user/orders/bloc/bloc/data_from_admin/data_from_admin_state.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class DataFromAdminBloc extends Bloc<DataFromAdminEvent, DataFromAdminState> {
  DataFromAdminBloc()
      : super(DataFromAdminState(
            message: '', status: ResponseStatus.pure, index: 0)) {
    on<GetBannersEvent>(getBanners);
    on<ChangeIndexEvent>(changeIndex);
  }

  Future<void> getBanners(GetBannersEvent event, Emitter emit) async {
    emit(state.copyWith(status: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<DataFromAdminRepository>().getAdminData();
    if (myResponse.statusCode! == 200) {
      emit(state.copyWith(
          data: myResponse.data, status: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          status: ResponseStatus.inFail, message: myResponse.message));
    }
  }

  void changeIndex(ChangeIndexEvent event, Emitter emit) {
    emit(state.copyWith(index: event.index));
  }
}
