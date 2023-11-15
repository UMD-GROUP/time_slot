// ignore_for_file: always_declare_return_types

import 'dart:io';

import 'package:time_slot/utils/tools/file_importers.dart';

Future<void> initFirebase() async {
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp(
        name: 'timeslot',
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDKJP0QOYtTWaNrNaqTzrrljMmMF7D8FDk',
            appId: '1:605235329516:android:2c8e0a05ab2a55935468c9',
            messagingSenderId: '605235329516',
            projectId: 'timeslot-6b4dc'));
  }
  await FirebaseMessaging.instance.subscribeToTopic('/topics/news');

  // String? fcmToken = await FirebaseMessaging.instance.getToken();

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // FOREGROUND MESSAGE HANDLING.
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint(
        "NOTIFICATION FOREGROUND MODE: ${message.data["news_image"]} va ${message.notification!.title} in foreground");
    LocalNotificationService.localNotificationService
        .showNotification(NotificationModel.fromJson(message.data));
    getIt<NotificationBloc>()
        .add(AddNotificationEvent(NotificationModel.fromJson(message.data)));

    // if (context.mounted) context.read<NewsProvider>().readNews();
  });

  // BACkGROUND MESSAGE HANDLING
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FROM TERMINATED MODE

  handleMessage(RemoteMessage message) async {
    debugPrint(
        "NOTIFICATION FROM TERMINATED MODE: ${message.data["news_image"]} va ${message.notification!.title} in terminated");
    getIt<NotificationBloc>()
        .add(AddNotificationEvent(NotificationModel.fromJson(message.data)));
  }

  final RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (remoteMessage != null) {
    await handleMessage(remoteMessage);
    getIt<NotificationBloc>().add(
        AddNotificationEvent(NotificationModel.fromJson(remoteMessage.data)));

    // if (context.mounted) context.read<NewsProvider>().readNews();
  }

  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('notifList');
  getIt<NotificationBloc>()
      .add(AddNotificationEvent(NotificationModel.fromJson(message.data)));
  debugPrint(
      "NOTIFICATION BACKGROUND MODE: ${message.data["news_image"]} va ${message.notification!.title} in background");
}
