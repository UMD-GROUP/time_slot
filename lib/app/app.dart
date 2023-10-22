// ignore_for_file: prefer_expression_function_bodies

import 'package:time_slot/service/storage_service/storage_service.dart';
import 'package:time_slot/ui/admin/admin_home/bloc/promo_codes_bloc/promo_code_bloc.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(providers: [
        BlocProvider(create: (context) => PageControllerBloc()),
        BlocProvider(create: (context) => CreateOrderBloc()),
        BlocProvider(create: (context) => DataFromAdminBloc()),
        BlocProvider(create: (context) => AllUserBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => UserAccountBloc()),
        BlocProvider(create: (context) => AdminBloc()),
        BlocProvider(
            create: (context) => PromoCodeBloc()..add(GetPromoCodesEvent())),
      ], child: const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String lang = getIt<StorageService>().getString('language');
    lang = lang.isEmpty ? 'uz' : lang;
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AdaptiveTheme(
          builder: (light, dark) => GetMaterialApp(
            translations: AppTranslations(),
            locale: Locale(lang, lang.toUpperCase()),
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
