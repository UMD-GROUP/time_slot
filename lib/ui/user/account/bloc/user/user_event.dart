part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUserDataEvent extends UserEvent {
  GetUserDataEvent(this.uid);
  String uid;
}

class AddMarketToUserEvent extends UserEvent {
  AddMarketToUserEvent(this.market);
  String market;
}
