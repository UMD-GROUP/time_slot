import 'package:time_slot/utils/tools/file_importers.dart';

class RowText extends StatelessWidget {
  RowText(
      {super.key,
      required this.icon,
      required this.text1,
      required this.text2,
      this.isVisible = true,
      this.textColor});
  String icon;
  String text1;
  String text2;
  Color? textColor;
  bool isVisible;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: isVisible,
        child: Row(
          children: [
            SvgPicture.asset(icon,
                color: AdaptiveTheme.of(context).theme.hintColor),
            SizedBox(width: width(context) * 0.01),
            Text(text1.tr,
                style: AppTextStyles.labelLarge(context, fontSize: 16.sp)),
            SizedBox(width: width(context) * 0.01),
            Text(text2.tr,
                style: AppTextStyles.labelLarge(context, color: textColor)),
          ],
        ),
      );
}
