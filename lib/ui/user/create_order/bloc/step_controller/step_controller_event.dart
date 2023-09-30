part of 'step_controller_bloc.dart';

@immutable
abstract class StepControllerEvent {}

class ToNextStepEvent extends StepControllerEvent {}

class ToPreviousStepEvent extends StepControllerEvent {}

class ToStepEvent extends StepControllerEvent {
  ToStepEvent(this.step);
  int step;
}
