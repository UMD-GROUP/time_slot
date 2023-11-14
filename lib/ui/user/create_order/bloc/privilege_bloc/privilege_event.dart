part of 'privilege_bloc.dart';

@immutable
abstract class PrivilegeEvent {}

class GetTheReverseEvent extends PrivilegeEvent {
  GetTheReverseEvent(this.day);
  DateTime? day;
}

class GetThePromoCodeEvent extends PrivilegeEvent {
  GetThePromoCodeEvent(this.promoCode);
  String promoCode;
}
