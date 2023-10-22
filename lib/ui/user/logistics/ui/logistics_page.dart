import 'package:time_slot/utils/tools/file_importers.dart';

class LogisticsPage extends StatelessWidget {
  const LogisticsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('logistics'.tr),
        ),
        body: Container(
          padding: EdgeInsets.all(20.h),
          height: height(context),
          width: width(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_clock_rounded,
                  size: 80.h,
                  color: Colors.grey,
                ),
                Text(
                  'soon_logistics'.tr,
                  style: AppTextStyles.labelLarge(context, fontSize: 18.sp),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      );
}
