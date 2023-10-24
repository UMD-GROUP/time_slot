import 'package:time_slot/utils/tools/file_importers.dart';

class FreeLimitWidget extends StatelessWidget {
  const FreeLimitWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        height: height(context) * 0.05,
        width: width(context),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurpleAccent),
            borderRadius: BorderRadius.circular(10.h)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline,
                    color: AdaptiveTheme.of(context).theme.hintColor),
                Text(
                    '${'free_limits'.tr}${context.read<UserAccountBloc>().state.user.freeLimits} ${'piece'.tr}',
                    style: AppTextStyles.labelLarge(context,
                        fontSize: 16.sp, fontWeight: FontWeight.w800))
              ],
            ),
            IconButton(
                onPressed: () {
                  showFreeLimitDialog(context);
                },
                icon: Icon(Icons.info_outlined,
                    color: AdaptiveTheme.of(context).theme.hintColor))
          ],
        ),
      );
}
