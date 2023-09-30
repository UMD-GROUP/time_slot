part of 'page_controller_bloc.dart';

@immutable
abstract class PageControllerEvent {}

class ChangeCurrentPageEvent extends PageControllerEvent {
  ChangeCurrentPageEvent(this.index);
  int index;
}
