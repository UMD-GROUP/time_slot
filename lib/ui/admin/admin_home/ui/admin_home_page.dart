import 'package:time_slot/ui/admin/admin_home/ui/widget/admin_banner_widget.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/admin_tabbar.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/other_view.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/prices_view.dart';

import '../../../../utils/tools/file_importers.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
            title: Text('admin_panel'.tr),
            backgroundColor: Colors.deepPurple,
            automaticallyImplyLeading: false),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height(context) * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child:
                  Text('banners'.tr, style: AppTextStyles.bodyMedium(context)),
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            const AdminBannerWidget(),
            SizedBox(
              height: height(context) * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'prices'.tr,
                style: AppTextStyles.bodyMedium(context),
              ),
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            const PricesView(),
            SizedBox(
              height: height(context) * 0.01,
            ),
            const OtherView(),
            SizedBox(
              height: height(context) * 0.03,
            ),
            const Expanded(child: AdminTabBarWidget()),
          ],
        ),
      );
}
