import 'package:time_slot/ui/admin/admin_home/ui/widget/admin_tabbar_item.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/all_orders_widget.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/all_promo_codes_widget.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/all_users_widget.dart';

import '../../../../../utils/tools/file_importers.dart';

class AdminTabBarWidget extends StatefulWidget {
  const AdminTabBarWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminTabBarWidgetState createState() => _AdminTabBarWidgetState();
}

class _AdminTabBarWidgetState extends State<AdminTabBarWidget> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
                      isActive: _currentIndex == 0,
                      context: context,
                      onTap: () {
                        _onTabTapped(0);
                      }),
                  AdminTabBarItem(
                      text: 'users',
                      isActive: _currentIndex == 1,
                      context: context,
                      onTap: () {
                        _onTabTapped(1);
                      }),
                  AdminTabBarItem(
                      text: 'promo_codes'.tr,
                      isActive: _currentIndex == 2,
                      context: context,
                      onTap: () {
                        _onTabTapped(2);
                      }),
                  AdminTabBarItem(
                      text: 'pay',
                      isActive: _currentIndex == 3,
                      context: context,
                      onTap: () {
                        _onTabTapped(3);
                      }),
                ],
              ),
            ),
          ),
          _currentIndex == 0
              ? const AllOrdersWidget()
              : _currentIndex == 1
                  ? const AllUsersWidget(
                      isPartner: false,
                    )
                  : _currentIndex == 2
                      ? AllPromoCodesWidget(isAdmin: true)
                      : const SizedBox()
        ],
      );
}
