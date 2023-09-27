import 'package:time_slot/utils/tools/file_importers.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc()
      : super(AuthorizationState(message: '', status: ResponseStatus.pure)) {
    on<SignInEvent>(signIn);
    on<CreateAccountEvent>(createAccount);
  }

  signIn(SignInEvent event, emit) async {
    if (EmailValidator.validate(event.user.email) &&
        event.user.password.length > 7) {
      MyResponse myResponse = MyResponse();
      emit(state.copyWith(status: ResponseStatus.inProgress));
      myResponse = await getIt<AuthorizationRepository>().signIn(event.user);
      if (myResponse.message.isNull) {
        emit(state.copyWith(status: ResponseStatus.inSuccess));
      } else {
        emit(state.copyWith(
            status: ResponseStatus.inFail, message: myResponse.message));
      }
    } else {
      emit(state.copyWith(
          status: ResponseStatus.inFail,
          message: !EmailValidator.validate(event.user.email)
              ? "email_not_valid".tr
              : "password_invalid".tr));
    }
    emit(state.copyWith(status: ResponseStatus.pure));
  }

  createAccount(CreateAccountEvent event, emit) async {
    if (EmailValidator.validate(event.user.email) &&
        event.user.password.length > 7 &&
        event.user.referallId.isNotEmpty) {
      MyResponse myResponse = MyResponse();
      emit(state.copyWith(status: ResponseStatus.inProgress));
      myResponse =
          await getIt<AuthorizationRepository>().createAnAccount(event.user);
      if (myResponse.message.isNull) {
        emit(state.copyWith(status: ResponseStatus.inSuccess));
      } else {
        emit(state.copyWith(
            status: ResponseStatus.inFail, message: myResponse.message));
      }
    } else {
      print(event.user.password);
      emit(state.copyWith(
          status: ResponseStatus.inFail,
          message: event.user.referallId.isEmpty
              ? "referall_not_valid"
              : !EmailValidator.validate(event.user.email)
                  ? "email_not_valid".tr
                  : "password_invalid".tr));
    }
    emit(state.copyWith(status: ResponseStatus.pure));
  }
}
