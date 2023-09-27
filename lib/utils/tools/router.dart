import 'package:time_slot/ui/authorization/ui/authorization_page.dart';

import 'file_importers.dart';

abstract class RouteName {
  static const splash = 'splash';
  static const userMain = '/userMain';
  static const authorization = '/authorization';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteName.authorization:
        return MaterialPageRoute(builder: (_) => const AuthorizationPage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
