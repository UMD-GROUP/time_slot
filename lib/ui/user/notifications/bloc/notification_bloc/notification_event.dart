part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class GetAllNotificationsEvent extends NotificationEvent {}

class AddNotificationEvent extends NotificationEvent {
  AddNotificationEvent(this.notification);
  NotificationModel notification;
}

class UpdateNotificationEvent extends NotificationEvent {
  UpdateNotificationEvent(this.notification, this.index);
  int index;
  NotificationModel notification;
}

class RemoveNotificationEvent extends NotificationEvent {
  RemoveNotificationEvent(this.index);
  int index;
}

class MakeRatedEvent extends NotificationEvent {
  MakeRatedEvent(this.orderId);
  int orderId;
}
