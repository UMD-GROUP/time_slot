import 'package:time_slot/utils/tools/file_importers.dart';

class RowText extends StatelessWidget {
  RowText(
      {required this.icon,
      required this.text1,
      required this.text2,
      this.textColor,
      super.key});
  String icon;
  String text1;
  String text2;
  Color? textColor;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          SvgPicture.asset(icon),
          Text(text1.tr),
          Text(text2.tr,
              style: AppTextStyles.labelLarge(context, color: textColor)),
        ],
      );
}
