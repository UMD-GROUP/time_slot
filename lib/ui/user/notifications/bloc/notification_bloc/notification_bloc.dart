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
  }

  getNotifications(event, emit) async {
    final List notifications =
        getIt<NotificationsRepository>().getNotifications();
    emit(state.copyWith(
        notifications: notifications, status: ResponseStatus.inSuccess));
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
}
