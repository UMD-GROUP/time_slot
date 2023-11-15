part of 'notification_bloc.dart';

@immutable
class NotificationState extends Equatable {
  NotificationState(
      {this.status = ResponseStatus.pure,
      this.message = '',
      this.hasUnReadMessage = false,
      this.orderId = -1,
      this.needRate = false,
      required this.notifications});
  String message;
  List notifications;
  ResponseStatus status;
  bool needRate;
  int orderId;
  bool hasUnReadMessage;

  NotificationState copyWith(
          {String? message,
          List? notifications,
          ResponseStatus? status,
          bool? hasUnReadMessage,
          bool? needRate,
          int? orderId}) =>
      NotificationState(
          hasUnReadMessage: hasUnReadMessage ?? this.hasUnReadMessage,
          orderId: orderId ?? this.orderId,
          notifications: notifications ?? this.notifications,
          needRate: needRate ?? this.needRate,
          status: status ?? this.status,
          message: message ?? this.message);
  @override
  List<Object?> get props =>
      [notifications, message, status, needRate, orderId, hasUnReadMessage];
}
