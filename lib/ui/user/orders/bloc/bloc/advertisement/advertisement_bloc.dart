import 'package:time_slot/utils/tools/file_importers.dart';

class AdvertisementBloc extends Bloc<AdvertisementEvent, AdvertisementState> {
  AdvertisementBloc()
      : super(AdvertisementState(
            message: '',
            status: ResponseStatus.pure,
            banners: const [],
            index: 0)) {
    on<GetBannersEvent>(getBanners);
    on<ChangeIndexEvent>(changeIndex);
  }

  Future<void> getBanners(GetBannersEvent event, Emitter emit) async {
    emit(state.copyWith(status: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<AdvertisementRepository>().getBanners();
    if (myResponse.statusCode! == 200) {
      emit(state.copyWith(
          banners: myResponse.data, status: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          status: ResponseStatus.inFail, message: myResponse.message));
    }
  }

  void changeIndex(ChangeIndexEvent event, Emitter emit) {
    emit(state.copyWith(index: event.index));
  }
}
