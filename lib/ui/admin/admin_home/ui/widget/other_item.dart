import 'package:time_slot/utils/tools/file_importers.dart';

class OtherItem extends StatelessWidget {
  OtherItem(
      {required this.title,
      required this.onTap,
      required this.subtitle,
      super.key});
  String title;
  String subtitle;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) => OnTap(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(4.h),
          child: Column(
            children: [
              Text(
                title.tr.length > 7
                    ? '${title.tr.substring(0, 7)}...'
                    : title.tr,
                style: AppTextStyles.bodyMedium(context),
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  alignment: Alignment.center,
                  height: height(context) * 0.043,
                  width: width(context) * 0.22,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Text(subtitle,
                      style: AppTextStyles.labelLarge(context,
                          color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      );
}
