import '../../../../../utils/tools/file_importers.dart';

class PurchaseTextWidget extends StatelessWidget {
  const PurchaseTextWidget(
      {super.key,
      this.isVisible = true,
      required this.icon,
      this.textColor,
      required this.text1,
      required this.text2});
  final String icon;
  final String text1;
  final String text2;
  final Color? textColor;
  final bool isVisible;
  @override
  Widget build(BuildContext context) => Visibility(
        visible: isVisible,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: AdaptiveTheme.of(context).theme.canvasColor,
              height: height(context) * 0.022,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              text1.tr,
              style: AppTextStyles.bodyMedium(
                context,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              text2,
              style: AppTextStyles.bodyMedium(context,
                  fontSize: 15.sp, color: textColor),
            ),
          ],
        ),
      );
}
