part of 'validator_bloc.dart';

@immutable
abstract class ValidatorEvent {}

class ValidateEvent extends ValidatorEvent {
  ValidateEvent({this.email, this.password});
  String? email;
  String? password;
}
