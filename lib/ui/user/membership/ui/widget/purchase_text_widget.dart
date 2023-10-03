import '../../../../../utils/tools/file_importers.dart';

class PurchaseTextWidget extends StatelessWidget {
  const PurchaseTextWidget({super.key, required this.icon, required this.text1, required this.text2});
  final String icon;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) => Row(
      children: [
        SvgPicture.asset(icon, color: AdaptiveTheme.of(context).theme.canvasColor, height: height(context)*0.025,),
        SizedBox(width: 5.w,),
        Text(text1.tr, style: AppTextStyles.bodyMedium(context),),
        SizedBox(width: 3.w,),
        Text(text2, style: AppTextStyles.bodyMedium(context),),
      ],
    );
}
