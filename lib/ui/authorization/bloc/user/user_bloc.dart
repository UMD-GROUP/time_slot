import 'package:time_slot/utils/tools/file_importers.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<GetUserDataEvent>(getUserData);
  }

  Future<void> getUserData(GetUserDataEvent event, Emitter emit) async {
    emit(state.copyWith(responseStatus: ResponseStatus.inProgress));
    final MyResponse myResponse =
        await getIt<UserRepository>().getUserData(event.uid);
    if (myResponse.message.isNull) {
      emit(state.copyWith(
          user: myResponse.data, responseStatus: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          responseStatus: ResponseStatus.inFail, message: myResponse.message));
    }
  }
}
