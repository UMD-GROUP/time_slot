import 'package:in_app_update/in_app_update.dart';
import 'package:time_slot/ui/user/account/ui/account_page.dart';
import 'package:time_slot/ui/user/membership/ui/membership_page.dart';
import 'package:time_slot/ui/user/orders/ui/orders_page.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AppUpdateInfo? _updateInfo;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    await InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List pages = [
      const OrdersPage(),
      const MembershipPage(),
      const AccountPage()
    ];

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == ResponseStatus.inSuccess && state.user!.isBlocked) {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.splash, (route) => false);
        }
      },
      child: BlocBuilder<PageControllerBloc, PageControllerState>(
        builder: (context, state) => Scaffold(
          body: pages[state.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              context
                  .read<PageControllerBloc>()
                  .add(ChangeCurrentPageEvent(value));
            },
            currentIndex: state.currentIndex,
            unselectedItemColor: AdaptiveTheme.of(context).theme.hintColor,
            selectedItemColor: Colors.deepPurple,
            backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home), label: 'orders'.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.monetization_on),
                  label: 'membership'.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person), label: 'account'.tr),
            ],
          ),
        ),
      ),
    );
  }
}
