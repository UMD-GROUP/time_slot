part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationEvent {}

class SignInEvent extends AuthorizationEvent {
  UserModel user;
  SignInEvent(this.user);
}

class CreateAccountEvent extends AuthorizationEvent {
  UserModel user;
  CreateAccountEvent(this.user);
}
