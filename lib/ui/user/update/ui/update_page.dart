import 'dart:io';

import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          title: Text('Seller PRO'.tr,
              style: AppTextStyles.labelLarge(context,
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800)),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 20.h, vertical: height(context) * 0.06),
          width: width(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Lottie.asset(AppLotties.hasUpdate,
                      width: width(context) * 0.6),
                  SizedBox(height: height(context) * 0.04),
                  Text('new_version_available'.tr,
                      style: AppTextStyles.labelLarge(context,
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  Text('update_to_use'.tr,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.labelLarge(context,
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
              GlobalButton(
                  onTap: () {
                    final String url = Platform.isAndroid
                        ? 'https://play.google.com/store/apps/details?id=com.uzmobdev.time_slot'
                        : 'https://apps.apple.com/uz/app/seller-pro/id6472054702';
                    launchUrlString(url);
                  },
                  textColor: Colors.white,
                  title: 'update'.tr,
                  color: Colors.deepPurple)
            ],
          ),
        ),
      );
}
