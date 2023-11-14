import 'package:time_slot/utils/tools/file_importers.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        onTap: (value) {
          context.read<PageControllerBloc>().add(ChangeCurrentPageEvent(value));
        },
        currentIndex: 1,
        unselectedItemColor: AdaptiveTheme.of(context).theme.hintColor,
        selectedItemColor: Colors.deepPurple,
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.timeline), label: 'Time Slot'.tr),
          BottomNavigationBarItem(
              icon: const Icon(Icons.car_repair_sharp), label: 'logistics'.tr),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: 'account'.tr),
        ],
      );
}
