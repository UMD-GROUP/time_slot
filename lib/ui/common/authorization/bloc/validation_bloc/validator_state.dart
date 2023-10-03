part of 'validator_bloc.dart';

@immutable
class ValidatorState extends Equatable {
  ValidatorState(
      {this.emailValidationStatus = ValidationStatus.pure,
      this.passwordValidationStatus = ValidationStatus.pure,
      this.password = '',
      this.email = '',
      this.allFieldsValidationStatus = ValidationStatus.pure});
  ValidationStatus emailValidationStatus;
  ValidationStatus passwordValidationStatus;
  ValidationStatus allFieldsValidationStatus;
  String email;
  String password;

  ValidatorState copyWith(
          {ValidationStatus? emailValidationStatus,
          ValidationStatus? passwordValidationStatus,
          ValidationStatus? allFieldsValidationStatus,
          String? email,
          String? password}) =>
      ValidatorState(
          allFieldsValidationStatus:
              allFieldsValidationStatus ?? this.allFieldsValidationStatus,
          emailValidationStatus:
              emailValidationStatus ?? this.emailValidationStatus,
          email: email ?? this.email,
          password: password ?? this.password,
          passwordValidationStatus:
              passwordValidationStatus ?? this.passwordValidationStatus);

  @override
  List<Object?> get props => [
        emailValidationStatus,
        passwordValidationStatus,
        allFieldsValidationStatus,
        email,
        password
      ];
}
