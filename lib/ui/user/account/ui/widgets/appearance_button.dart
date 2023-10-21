import 'package:time_slot/utils/tools/file_importers.dart';

class AppearanceButton extends StatelessWidget {
  AppearanceButton(this.title,
      {required this.onTap,
      this.isOnBoard = false,
      required this.icon,
      super.key});
  String title;
  VoidCallback onTap;
  IconData icon;
  bool isOnBoard;

  @override
  Widget build(BuildContext context) => OnTap(
        onTap: onTap,
        child: Container(
          height: isOnBoard ? height(context) * 0.05 : height(context) * 0.07,
          width: isOnBoard ? width(context) * 0.28 : width(context) * 0.44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepPurple)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: AdaptiveTheme.of(context).theme.hintColor,
              ),
              Text(
                title.tr,
                style: AppTextStyles.bodyLarge(context,
                    fontWeight: FontWeight.w600,
                    fontSize: isOnBoard ? 12.h : 15.h),
              )
            ],
          ),
        ),
      );
}
