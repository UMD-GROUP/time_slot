part of 'validator_bloc.dart';

@immutable
class ValidatorState extends Equatable {
  ValidationStatus emailValidationStatus;
  ValidationStatus passwordValidationStatus;
  ValidationStatus allFieldsValidationStatus;
  String email;
  String password;

  ValidatorState(
      {this.emailValidationStatus = ValidationStatus.pure,
      this.passwordValidationStatus = ValidationStatus.pure,
      this.password = '',
      this.email = '',
      this.allFieldsValidationStatus = ValidationStatus.pure});

  copyWith(
      {ValidationStatus? emailValidationStatus,
      ValidationStatus? passwordValidationStatus,
      ValidationStatus? allFieldsValidationStatus,
      String? email,
      String? password}) {
    print("MANA email ${email ?? this.email}");
    print("MANA password ${password ?? this.password}");
    return ValidatorState(
        allFieldsValidationStatus:
            allFieldsValidationStatus ?? this.allFieldsValidationStatus,
        emailValidationStatus:
            emailValidationStatus ?? this.emailValidationStatus,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordValidationStatus:
            passwordValidationStatus ?? this.passwordValidationStatus);
  }

  @override
  List<Object?> get props => [
        emailValidationStatus,
        passwordValidationStatus,
        allFieldsValidationStatus,
        email,
        password
      ];
}
