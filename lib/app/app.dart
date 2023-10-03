// ignore_for_file: prefer_expression_function_bodies
import 'package:time_slot/ui/user/orders/bloc/bloc/data_from_admin/data_from_admin_bloc.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(providers: [
        BlocProvider(create: (context) => PageControllerBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => CreateOrderBloc()),
        BlocProvider(create: (context) => DataFromAdminBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => PurchaseBloc()),
        BlocProvider(create: (context) => UserAccountBloc()),
      ], child: const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AdaptiveTheme(
          builder: (light, dark) => GetMaterialApp(
            translations: AppTranslations(),
            locale: const Locale('uz', 'UZ'),

            // locale: Locale(
            //     getIt<SettingsRepository>().getLanguage() == "ru" ? "ru" : "uz",
            //     getIt<SettingsRepository>().getLanguage() == "ru"
            //         ? "RU"
            //         : "UZ"),
            initialRoute: RouteName.splash,
            onGenerateRoute: AppRoutes.generateRoute,
            debugShowCheckedModeBanner: false,
            // home: Material(child: EnterInfoPage()),
            title: 'TimeSlot',
          ),
          light: AppTheme.light,
          initial: AdaptiveThemeMode.light,
          dark: AppTheme.dark,
        );
      },
    );
  }
}
