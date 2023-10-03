import '../../../../../utils/tools/file_importers.dart';

class UserCardButton extends StatelessWidget {
  const UserCardButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
        height: height(context)*0.04,
        width: height(context)*0.19,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(6.r)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.download, color: Colors.white,height: height(context)*0.03),
                SizedBox(height: 5.h,)
              ],
            ),
            SizedBox(width: 5.w,),
            Text('purchase'.tr, style: AppTextStyles.bodyMedium(context,color: Colors.white),)
          ],
        ),
      ),
  );
}
