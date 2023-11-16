import 'package:time_slot/ui/admin/admin_home/ui/widget/admin_tabbar_item.dart';

import '../../../../../utils/tools/file_importers.dart';
import 'add_reserve_widget.dart';

class AdminTabBarWidget extends StatefulWidget {
  const AdminTabBarWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminTabBarWidgetState createState() => _AdminTabBarWidgetState();
}

class _AdminTabBarWidgetState extends State<AdminTabBarWidget> {
  @override
  void initState() {
    context.read<ReserveBloc>().add(GetAllReservesEvent());

    super.initState();
  }

  void _onTabTapped(int index) {
    Navigator.pushNamed(context, RouteName.controlPage, arguments: index);
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              height: height(context) * 0.06,
              decoration: BoxDecoration(
                  color: AdaptiveTheme.of(context).theme.disabledColor,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(width: 0.5, color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdminTabBarItem(
                      text: 'orders',
                      context: context,
                      onTap: () {
                        _onTabTapped(0);
                      }),
                  AdminTabBarItem(
                      text: 'users',
                      context: context,
                      onTap: () {
                        _onTabTapped(1);
                      }),
                  AdminTabBarItem(
                      text: 'markets'.tr,
                      context: context,
                      onTap: () {
                        _onTabTapped(2);
                      }),
                  AdminTabBarItem(
                      text: 'promo_codes'.tr,
                      context: context,
                      onTap: () {
                        _onTabTapped(3);
                      }),
                ],
              ),
            ),
          ),
          const AddReserveWidget()
          // _currentIndex == 0
          //     ? const AllOrdersWidget()
          //     : _currentIndex == 1
          //         ? const AllUsersWidget(
          //             isPartner: false,
          //           )
          //         : _currentIndex == 2
          //             ? AllPromoCodesWidget(isAdmin: true)
          //             : const AddReserveWidget()
        ],
      );
}
