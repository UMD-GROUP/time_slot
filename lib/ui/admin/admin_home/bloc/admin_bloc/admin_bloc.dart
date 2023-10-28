import 'package:time_slot/utils/tools/file_importers.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminState()) {
    on<AddBannerEvent>(addBanner);
    on<RemoveBannerEvent>(removeBanner);
    on<UpdatePricesEvent>(updatePrices);
    on<UpdateOtherEvent>(updateOthers);
    on<UpdateOrderEvent>(updateOrder);
    on<UpdateUserBEvent>(updateUser);
  }

  Future<void> addBanner(AddBannerEvent event, Emitter emit) async {
    emit(state.copyWith(addBannerStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<AdminRepository>().addBanner(event.path, event.data);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(addBannerStatus: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          addBannerStatus: ResponseStatus.inFail, message: myResponse.message));
    }
    emit(state.copyWith(addBannerStatus: ResponseStatus.pure));
  }

  Future<void> removeBanner(RemoveBannerEvent event, Emitter emit) async {
    emit(state.copyWith(deleteBannerStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<AdminRepository>().removeBanner(event.path, event.data);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(deleteBannerStatus: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          deleteBannerStatus: ResponseStatus.inFail,
          message: myResponse.message));
    }
    emit(state.copyWith(deleteBannerStatus: ResponseStatus.pure));
  }

  Future<void> updatePrices(UpdatePricesEvent event, Emitter emit) async {
    emit(state.copyWith(updatePricesStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<AdminRepository>().updatePrices(event.data);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(updatePricesStatus: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          updatePricesStatus: ResponseStatus.inFail,
          message: myResponse.message));
    }
    emit(state.copyWith(updatePricesStatus: ResponseStatus.pure));
  }

  Future<void> updateOthers(UpdateOtherEvent event, Emitter emit) async {
    emit(state.copyWith(updateOthersStatus: ResponseStatus.inProgress));
    final MyResponse myResponse = await getIt<AdminRepository>()
        .updateOther(event.deliveryNote, event.memberPercent, data: event.data);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(updateOthersStatus: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          updateOthersStatus: ResponseStatus.inFail,
          message: myResponse.message));
    }
    emit(state.copyWith(updateOthersStatus: ResponseStatus.pure));
  }

  Future<void> updateOrder(UpdateOrderEvent event, Emitter emit) async {
    emit(state.copyWith(updateOrderState: ResponseStatus.inProgress));
    final MyResponse myResponse = await getIt<AdminRepository>().updateOrder(
        event.order, event.percent, event.lastStatus,
        photo: event.photo);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(updateOrderState: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          updateOrderState: ResponseStatus.inFail,
          message: myResponse.message));
    }
    emit(state.copyWith(updateOrderState: ResponseStatus.pure));
  }

  Future<void> updateUser(UpdateUserBEvent event, Emitter emit) async {
    print(event.user.isBlocked);
    emit(state.copyWith(userUpdatingStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<AdminRepository>().updateUser(event.user);
    if (myResponse.statusCode == 200) {
      emit(state.copyWith(userUpdatingStatus: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          updateOrderState: ResponseStatus.inFail,
          message: myResponse.message));
    }
    emit(state.copyWith(userUpdatingStatus: ResponseStatus.pure));
  }
}
