part of 'page_controller_bloc.dart';

@immutable
class PageControllerState extends Equatable {
  PageControllerState(this.currentIndex);
  int currentIndex;

  PageControllerState copyWith(int? currentIndex) =>
      PageControllerState(currentIndex ?? this.currentIndex);
  @override
  List<Object?> get props => [currentIndex];
}
