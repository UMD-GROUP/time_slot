import 'package:flutter/material.dart';
import 'package:time_slot/ui/admin/control/ui/sub_pages/all_matkets_page.dart';
import 'package:time_slot/ui/admin/control/ui/sub_pages/all_orders_page.dart';
import 'package:time_slot/ui/admin/control/ui/sub_pages/all_promo_codes_page.dart';
import 'package:time_slot/ui/admin/control/ui/sub_pages/all_users_page.dart';

class ControlPage extends StatelessWidget {
  ControlPage(this.index, {super.key});
  int index;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const AllOrdersPage(),
      const AllUsersPage(),
      const AllMarketsPage(),
      const AllPromoCodesPage()
    ];
    return pages[index];
  }
}
