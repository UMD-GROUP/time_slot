import 'package:time_slot/utils/tools/file_importers.dart';

class RowText extends StatelessWidget {
  RowText(
      {super.key,
      this.icon,
      this.fontSize,
      required this.text1,
      this.iconData,
      required this.text2,
      this.isVisible = true,
      this.textColor});
  String? icon;
  String text1;
  String text2;
  Color? textColor;
  bool isVisible;
  IconData? iconData;
  double? fontSize;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: isVisible,
        child: Row(
          children: [
            iconData.isNull
                ? SvgPicture.asset(
                    icon!,
                    color: AdaptiveTheme.of(context).theme.hintColor,
                    height: 20.h,
                  )
                : Icon(
                    iconData,
                    color: AdaptiveTheme.of(context).theme.hintColor,
                    size: 20.h,
                  ),
            SizedBox(width: width(context) * 0.01),
            Text(text1.tr,
                style: AppTextStyles.labelLarge(context,
                    fontSize: fontSize ?? 16.sp)),
            SizedBox(width: width(context) * 0.01),
            Text(
                text2.tr.length > 20
                    ? '${text2.tr.substring(0, 20)}...'
                    : text2.tr,
                style: AppTextStyles.labelLarge(context,
                    color: textColor, fontSize: fontSize)),
          ],
        ),
      );
}
