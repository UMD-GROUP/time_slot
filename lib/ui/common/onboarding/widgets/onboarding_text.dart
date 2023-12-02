import '../../../../utils/tools/file_importers.dart';

class OnBoardingText extends StatelessWidget {
  OnBoardingText({required this.title, super.key});
  String title;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.circle_outlined,
                color: title.contains('4') ? Colors.green : Colors.red),
            SizedBox(
              width: width(context) * 0.78,
              child: Text(
                title.tr,
                style: AppTextStyles.labelSBold(context, fontSize: 18),
                maxLines: 5,
              ),
            )
          ],
        ),
      );
}
