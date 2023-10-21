import 'package:time_slot/utils/tools/file_importers.dart';

part 'validator_event.dart';
part 'validator_state.dart';

class ValidatorBloc extends Bloc<ValidatorEvent, ValidatorState> {
  ValidatorBloc() : super(ValidatorState()) {
    on<ValidateEvent>(validate);
  }

  void validate(ValidateEvent event, Emitter emit) {
    emit(state.copyWith(
      email: event.email,
      password: event.password,
    ));
    emit(state.copyWith(
      passwordValidationStatus: state.password.isNull
          ? null
          : state.password!.length > 7
              ? ValidationStatus.valid
              : ValidationStatus.notValid,
      emailValidationStatus: state.email.isNull
          ? null
          : EmailValidator.validate(state.email!)
              ? ValidationStatus.valid
              : ValidationStatus.notValid,
    ));
  }
}
