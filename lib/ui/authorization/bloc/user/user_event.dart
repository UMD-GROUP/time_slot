part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUserDataEvent extends UserEvent {
  GetUserDataEvent(this.uid);
  String uid;
}
