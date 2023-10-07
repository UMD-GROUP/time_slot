import 'package:time_slot/ui/user/account/ui/account_page.dart';
import 'package:time_slot/ui/user/membership/ui/membership_page.dart';
import 'package:time_slot/ui/user/orders/ui/orders_page.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.monetization_on), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          ),
        ),
      ),
    );
  }
}
