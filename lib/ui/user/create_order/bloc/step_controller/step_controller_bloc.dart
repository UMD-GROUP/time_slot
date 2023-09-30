import 'package:time_slot/utils/tools/file_importers.dart';

part 'step_controller_event.dart';
part 'step_controller_state.dart';

class StepControllerBloc
    extends Bloc<StepControllerEvent, StepControllerState> {
  StepControllerBloc() : super(StepControllerState()) {
    on<ToNextStepEvent>(toNextStep);
    on<ToPreviousStepEvent>(toPreviousStep);
    on<ToStepEvent>(toStepEvent);
  }

  void toNextStep(ToNextStepEvent event, Emitter emit) {
    emit(state.copyWith(
        currentStep:
            state.currentStep < 3 ? state.currentStep + 1 : state.currentStep,
        isFinished: state.currentStep > 3));
  }

  void toPreviousStep(ToPreviousStepEvent event, Emitter emit) {
    emit(state.copyWith(
        currentStep:
            state.currentStep > 0 ? state.currentStep-- : state.currentStep));
  }

  void toStepEvent(ToStepEvent event, Emitter emit) {
    emit(state.copyWith(currentStep: event.step));
  }
}
