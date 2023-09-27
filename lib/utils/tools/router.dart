import 'file_importers.dart';

abstract class RouteName {
  static const splash = 'splash';
  static const userMain = '/userMain';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
