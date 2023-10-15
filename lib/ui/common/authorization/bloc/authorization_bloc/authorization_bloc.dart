// ignore_for_file: cascade_invocations

import 'package:time_slot/utils/tools/file_importers.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc()
      : super(AuthorizationState(message: '', status: ResponseStatus.pure)) {
    on<SignInEvent>(signIn);
    on<CreateAccountEvent>(createAccount);
    on<CreateAccountWithGoogleEvent>(createAccountWithGoogle);
  }

  Future<void> signIn(SignInEvent event, Emitter emit) async {
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
              ? 'email_not_valid'.tr
              : 'password_invalid'.tr));
    }
    emit(state.copyWith(status: ResponseStatus.pure));
  }

  Future<void> createAccount(CreateAccountEvent event, Emitter emit) async {
    if (EmailValidator.validate(event.user.email) &&
        event.user.password.length > 7) {
      MyResponse myResponse = MyResponse();
      emit(state.copyWith(status: ResponseStatus.inProgress));
      final UserModel user = event.user;
      user.token = generateToken();
      myResponse = await getIt<AuthorizationRepository>().createAnAccount(user);
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
          message: !EmailValidator.validate(event.user.email)
              ? 'email_not_valid'.tr
              : 'password_invalid'.tr));
    }
    emit(state.copyWith(status: ResponseStatus.pure));
  }

  Future<void> createAccountWithGoogle(
      CreateAccountWithGoogleEvent event, Emitter emit) async {
    MyResponse myResponse = MyResponse();
    emit(state.copyWith(status: ResponseStatus.inProgress));
    myResponse = await getIt<AuthorizationRepository>()
        .createAnAccountWithGoogle(event.isSignIn);
    if (myResponse.message.isNull) {
      emit(state.copyWith(status: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(
          status: ResponseStatus.inFail, message: myResponse.message));
    }
    emit(state.copyWith(status: ResponseStatus.pure));
  }
}
