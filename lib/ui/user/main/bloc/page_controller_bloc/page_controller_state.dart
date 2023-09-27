part of 'page_controller_bloc.dart';

@immutable
class PageControllerState extends Equatable {
  int currentIndex;
  PageControllerState(this.currentIndex);

  copyWith(int? currentIndex) =>
      PageControllerState(currentIndex ?? this.currentIndex);
  @override
  List<Object?> get props => [currentIndex];
}
