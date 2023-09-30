part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUserDataEvent extends UserEvent {
  String uid;
  GetUserDataEvent(this.uid);
}
