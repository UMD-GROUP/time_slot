import 'package:time_slot/ui/user/account/data/models/store_model.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

part 'user_account_event.dart';
part 'user_account_state.dart';

class UserAccountBloc extends Bloc<UserAccountEvent, UserAccountState> {
  UserAccountBloc()
      : super(UserAccountState(user: UserModel(), stores: const [])) {
    on<AddMarketEvent>(addMarket);
    on<AddBankingCardEvent>(addBankingCard);
    on<GetUserDataEvent>(getUserData);
    on<GetUserStoresEvent>(getUserStores);
  }

  Future<void> getUserData(GetUserDataEvent event, Emitter emit) async {
    print(event.uid);
    emit(state.copyWith(getUserStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<UserRepository>().getUserData(event.uid);
    if (myResponse.message.isNull) {
      emit(state.copyWith(
          user: myResponse.data, getUserStatus: ResponseStatus.inSuccess));
      add(GetUserStoresEvent(state.user.uid));
    } else {
      emit(state.copyWith(
          getUserStatus: ResponseStatus.inFail, message: myResponse.message));
    }
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
        add(GetUserStoresEvent(state.user.uid));
      } else {
        emit(state.copyWith(
            addStoreStatus: ResponseStatus.inFail,
            message: myResponse.message));
      }
    }
    emit(state.copyWith(addStoreStatus: ResponseStatus.pure, message: ''));
  }

  Future<void> addBankingCard(AddBankingCardEvent event, Emitter emit) async {
    emit(state.copyWith(addCardStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<UserAccountRepository>().addBankingCard(event.bankingCard);
    if (myResponse.statusCode! == 200) {
      emit(state.copyWith(addCardStatus: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          addCardStatus: ResponseStatus.inFail, message: myResponse.message));
    }
    emit(state.copyWith(addCardStatus: ResponseStatus.pure));
  }

  Future<void> getUserStores(GetUserStoresEvent event, Emitter emit) async {
    emit(state.copyWith(getStoresStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<UserAccountRepository>().getUserStores(event.ownerId);
    if (myResponse.message.isNull) {
      emit(state.copyWith(
          stores: myResponse.data, getStoresStatus: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          getStoresStatus: ResponseStatus.inFail, message: myResponse.message));
    }
  }
}
