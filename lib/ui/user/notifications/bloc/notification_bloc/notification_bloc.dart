// ignore_for_file: type_annotate_public_apis, always_declare_return_types

import 'package:time_slot/ui/user/notifications/data/repository/notifications_repository.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationState(notifications: const [])) {
    on<GetAllNotificationsEvent>(getNotifications);
    on<AddNotificationEvent>(addNotification);
    on<UpdateNotificationEvent>(updateNotification);
    on<RemoveNotificationEvent>(removeNotification);
    on<MakeRatedEvent>(makeRated);
  }

  getNotifications(event, emit) async {
    final List notifications =
        getIt<NotificationsRepository>().getNotifications();
    emit(state.copyWith(
        notifications: notifications, status: ResponseStatus.inSuccess));
    checkRating();
  }

  addNotification(AddNotificationEvent event, emit) {
    getIt<NotificationsRepository>().addNotifications(event.notification);
    add(GetAllNotificationsEvent());
  }

  updateNotification(UpdateNotificationEvent event, emit) {
    getIt<NotificationsRepository>()
        .setAsReadNotification(event.notification, event.index);
  }

  removeNotification(RemoveNotificationEvent event, emit) {
    getIt<NotificationsRepository>().removeNotification(event.index);
    add(GetAllNotificationsEvent());
  }

  checkRating() {
    bool hasUnreadMessage = false;
    for (final NotificationModel i in state.notifications) {
      if (i.isRated == false && i.orderId != -1) {
        emit(state.copyWith(needRate: true, orderId: i.orderId));
      }
      if (i.isRead == false) {
        hasUnreadMessage = true;
      }
    }
    emit(state.copyWith(
        needRate: false, orderId: -1, hasUnReadMessage: hasUnreadMessage));
  }

  makeRated(MakeRatedEvent event, emit) {
    int index = 0;
    late NotificationModel notification;
    for (final NotificationModel i in state.notifications) {
      if (i.orderId == event.orderId) {
        notification = i;
        break;
      }
      index++;
    }
    notification.isRated = true;
    getIt<NotificationsRepository>().makeRated(notification, index);
    add(GetAllNotificationsEvent());
  }
}
