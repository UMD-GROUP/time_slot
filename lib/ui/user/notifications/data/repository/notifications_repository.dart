// ignore_for_file: type_annotate_public_apis, always_declare_return_types

import 'package:time_slot/service/notification/notification_saver.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class NotificationsRepository {
  static String boxName = 'notifications';
  addNotifications(NotificationModel notification) async {
    getIt<NotificationSaver>().addToBox(boxName, notification);
  }

  List getNotifications() => getIt<NotificationSaver>().getFromBox(boxName);

  setAsReadNotification(NotificationModel notification, int index) {
    getIt<NotificationSaver>().deleteFromBox(boxName, index);
    notification.isRead = true;
    getIt<NotificationSaver>().addToBox(boxName, notification);
  }

  removeNotification(int index) {
    getIt<NotificationSaver>().deleteFromBox(boxName, index);
  }

  makeRated(NotificationModel notification, int index) {
    getIt<NotificationSaver>().deleteFromBox(boxName, index);
    getIt<NotificationSaver>().addToBox(boxName, notification);
  }
}
