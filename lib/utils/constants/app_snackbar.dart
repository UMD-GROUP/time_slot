import 'package:time_slot/utils/tools/file_importers.dart';

class AppSnackBar extends StatelessWidget {
  final String text;
  final String icon;
  final Color color;
  const AppSnackBar(
      {Key? key, required this.text, required this.icon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: color)),
      width: width(context) * 0.95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(icon, width: width(context) * 0.2),
            // Icon(Icons.error, color: Colors.red),
            Container(
              height: height(context) * 0.05,
              width: 1,
              color: color,
            ),
            Text(
              text,
              maxLines: 5,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class AppErrorSnackBar extends StatelessWidget {
  final String text;
  const AppErrorSnackBar({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AdaptiveTheme.of(context).theme.backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1.r, color: AppColors.cFF3333)),
      width: width(context) * 0.95,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.error, color: Colors.red),
            Container(
              height: height(context) * 0.04,
              width: 1.w,
              color: AppColors.cD3D3D3,
            ),
            Text(
              text.tr,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: AppTextStyles.labelMedium(context,
                  fontSize: 14.h,
                  color: AdaptiveTheme.of(context).theme.hintColor),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
