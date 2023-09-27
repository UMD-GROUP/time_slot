part of 'validator_bloc.dart';

@immutable
abstract class ValidatorEvent {}

class ValidateEvent extends ValidatorEvent {
  String? email;
  String? password;

  ValidateEvent({this.email, this.password});
}
