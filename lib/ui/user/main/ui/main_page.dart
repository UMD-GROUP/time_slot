// ignore_for_file: type_annotate_public_apis, always_declare_return_types

import 'package:in_app_update/in_app_update.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  handleFirebaseNotificationMessages() async {
    String? fcmToken = '';
    // if (Platform.isAndroid) {
    fcmToken = await FirebaseMessaging.instance.getToken();
    // }
    // Clipboard.setData(ClipboardData(text: fcmToken ?? 'No token'));
    debugPrint('FCM USER TOKEN: $fcmToken');
    //Foregrounddan kelgan messagelarni tutib olamiz
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        LocalNotificationService.localNotificationService
            .showNotification(NotificationModel.fromJson(message.data));

        // getIt<NotificationsBloc>().add(SaveNotificationEvent(
        //     notificationModel: NotificationModel.fromJson(message.data)));
        // getIt<NotificationsBloc>().add(GetNotificationsEvent());
      }
    });
  }

  AppUpdateInfo? _updateInfo;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    handleFirebaseNotificationMessages();
    await InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        print('UPDATE BORORORORO');
        setState(() {
          _updateInfo = info;
          update();
        });
      } else {
        print("Update yo'gakan");
      }
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  Future<void> update() async {
    await InAppUpdate.startFlexibleUpdate();
    await InAppUpdate.completeFlexibleUpdate().then((value) {}).catchError((e) {
      print(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final List pages = [
      const OrdersPage(),
      const LogisticsPage(),
      const AccountPage()
    ];

    return BlocListener<UserAccountBloc, UserAccountState>(
      listener: (context, state) {
        if (state.getUserStatus == ResponseStatus.inSuccess &&
            state.user!.isBlocked) {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.splash, (route) => false);
        }
      },
      child: BlocBuilder<PageControllerBloc, PageControllerState>(
        builder: (context, state) => Scaffold(
          body: pages[state.currentIndex],
        ),
      ),
    );
  }
}
