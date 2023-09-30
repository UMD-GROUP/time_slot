part of 'step_controller_bloc.dart';

@immutable
class StepControllerState extends Equatable {
  StepControllerState({this.currentStep = 0, this.isFinished = false});
  int currentStep;
  bool isFinished;

  StepControllerState copyWith({int? currentStep, bool? isFinished}) =>
      StepControllerState(
          currentStep: currentStep ?? this.currentStep,
          isFinished: isFinished ?? this.isFinished);

  @override
  List<Object?> get props => [isFinished, currentStep];
}
