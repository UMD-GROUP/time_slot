// ignore_for_file: type_annotate_public_apis, always_declare_return_types

import 'package:time_slot/utils/tools/file_importers.dart';

class NotificationService {
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    getIt<NotificationBloc>()
        .add(AddNotificationEvent(NotificationModel.fromJson(message.data)));
  }

  handleFirebaseNotificationMessages() async {
    //Foregrounddan kelgan messagelarni tutib olamiz
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        LocalNotificationService.localNotificationService
            .showNotification(NotificationModel.fromJson(message.data));
        getIt<NotificationBloc>().add(
            AddNotificationEvent(NotificationModel.fromJson(message.data)));
      }
    });
  }

  setupInteractedMessage() async {
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    print('Shettala');

    //Terminateddan kirganda bu ishlaydi
    if (initialMessage != null) {
      getIt<NotificationBloc>().add(AddNotificationEvent(
          NotificationModel.fromJson(initialMessage.data)));
    }
    //Backgounddan kirganda shu ishlaydi
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('BAckround ishladiku janob');
      getIt<NotificationBloc>()
          .add(AddNotificationEvent(NotificationModel.fromJson(message.data)));
    });
  }
}
