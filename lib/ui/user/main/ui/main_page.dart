// ignore_for_file: type_annotate_public_apis, always_declare_return_types

import 'package:time_slot/utils/tools/file_importers.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
