import '../../../../../utils/tools/file_importers.dart';

class UserCardItem extends StatelessWidget {
  const UserCardItem({super.key, required this.icon, required this.text1, required this.text2, required this.text3});
  final String icon;
  final String text1;
  final String text2;
  final String text3;

  @override
  Widget build(BuildContext context) => Row(
      children: [
        SizedBox(width: width(context)*0.05,),
        SvgPicture.asset(icon, color: Colors.white,height: height(context)*0.022,),
        SizedBox(width: 5.w,),
        Text(
          '${text1.tr} $text2 ${text3.tr}',
          style: AppTextStyles.labelLarge(context,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ],
    );
}
