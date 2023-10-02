import '../../../../../utils/tools/file_importers.dart';

class StoreItem extends StatelessWidget {
  StoreItem({required this.index, required this.title, super.key});
  String title;
  int index;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width(context) * 0.1,
              child: Image.asset(
                AppImages.market,
                height: 40,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(width: width(context) * 0.01),
            SizedBox(
              width: width(context) * 0.25,
              child: Text(
                "${index + 1} - ${'store'.tr} : ",
                style: AppTextStyles.labelLarge(context,
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: width(context) * 0.42,
              child: Text(
                title,
                style: AppTextStyles.labelLarge(context,
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
}
