import 'package:time_slot/ui/admin/admin_home/ui/admin_home_page.dart';
import 'package:time_slot/ui/common/authorization/ui/authorization_page.dart';
import 'package:time_slot/ui/common/onboarding/onboarding_page.dart';
import 'package:time_slot/ui/user/create_order/ui/create_order_page.dart';
import 'package:time_slot/ui/user/main/ui/main_page.dart';
import 'package:time_slot/ui/user/notifications/ui/notifications_page.dart';

import 'file_importers.dart';

abstract class RouteName {
  static const splash = 'splash';
  static const userMain = '/userMain';
  static const authorization = '/authorization';
  static const createOrder = '/createOrder';
  static const adminHome = '/adminHome';
  static const onBoarding = '/onBoarding';
  static const notifications = '/notifications';
}

// ignore: avoid_classes_with_only_static_members
class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteName.authorization:
        return MaterialPageRoute(builder: (_) => const AuthorizationPage());
      case RouteName.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      case RouteName.userMain:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case RouteName.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsPage());
      case RouteName.adminHome:
        return MaterialPageRoute(builder: (_) => const AdminHomePage());
      case RouteName.createOrder:
        return MaterialPageRoute(builder: (_) => const CreateOrderPage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
