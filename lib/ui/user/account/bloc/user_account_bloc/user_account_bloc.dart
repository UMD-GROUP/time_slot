import 'package:time_slot/ui/user/account/data/repositories/user_account_repository.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

part 'user_account_event.dart';
part 'user_account_state.dart';

class UserAccountBloc extends Bloc<UserAccountEvent, UserAccountState> {
  UserAccountBloc() : super(UserAccountState()) {
    on<AddMarketEvent>(addMarket);
  }

  Future<void> addMarket(AddMarketEvent event, Emitter emit) async {
    emit(state.copyWith(addStoreStatus: ResponseStatus.inProgress));
    if (event.market.length < 3) {
      emit(state.copyWith(
          addStoreStatus: ResponseStatus.inFail,
          message: 'market_name_must_include_more_than_3_letters'.tr));
    } else {
      final MyResponse myResponse = await getIt<UserAccountRepository>()
          .addStore(event.market, event.user);
      if (myResponse.message.isNull) {
        emit(state.copyWith(
            addStoreStatus: ResponseStatus.inSuccess, message: event.market));
      } else {
        emit(state.copyWith(
            addStoreStatus: ResponseStatus.inFail,
            message: myResponse.message));
      }
    }
    emit(state.copyWith(addStoreStatus: ResponseStatus.pure, message: ''));
  }
}
