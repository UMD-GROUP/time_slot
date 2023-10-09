import 'package:time_slot/utils/tools/file_importers.dart';

class AccountActionButton extends StatelessWidget {
  AccountActionButton(this.title,
      {required this.onTap, required this.icon, super.key});
  IconData icon;
  String title;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) => OnTap(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          height: height(context) * 0.06,
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepPurple)),
          child: Row(
            children: [
              Icon(
                icon,
                color: AdaptiveTheme.of(context).theme.hintColor,
              ),
              SizedBox(width: width(context) * 0.02),
              Text(
                title.tr,
                style: AppTextStyles.bodyLarge(context,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      );
}
