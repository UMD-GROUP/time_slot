import '../../../../../utils/tools/file_importers.dart';

class InfoActionButton extends StatelessWidget {
  InfoActionButton(
      {required this.onTap,
      required this.title,
      required this.subtitle,
      required this.icon,
      super.key});
  String title;
  IconData icon;
  String subtitle;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) => OnTap(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(top: 6.h, bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width(context) * 0.4,
                child: Row(
                  children: [
                    Icon(icon,
                        color: AdaptiveTheme.of(context).theme.hintColor),
                    SizedBox(width: width(context) * 0.02),
                    Text(title.tr,
                        style: AppTextStyles.labelLarge(context,
                            fontWeight: FontWeight.w600, fontSize: 18))
                  ],
                ),
              ),
              Visibility(
                visible: subtitle.isNotEmpty,
                child: SizedBox(
                    width: width(context) * 0.5,
                    child: Text(subtitle,
                        textAlign: TextAlign.end,
                        style: AppTextStyles.labelLarge(context,
                            fontSize: 18,
                            color: Colors.deepPurple.withOpacity(0.8)))),
              ),
              Visibility(
                visible: subtitle.isEmpty,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple, // Background color
                    ),
                    onPressed: onTap,
                    child: Text('add'.tr)),
              )
            ],
          ),
        ),
      );
}
