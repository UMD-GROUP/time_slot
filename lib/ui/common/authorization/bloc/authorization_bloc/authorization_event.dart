part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationEvent {}

class SignInEvent extends AuthorizationEvent {
  SignInEvent(this.user);
  UserModel user;
}

class CreateAccountEvent extends AuthorizationEvent {
  CreateAccountEvent(this.user);
  UserModel user;
}

class CreateAccountWithGoogleEvent extends AuthorizationEvent {
  CreateAccountWithGoogleEvent(this.isSignIn);
  bool isSignIn;
}
