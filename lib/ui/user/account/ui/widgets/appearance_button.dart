import 'package:time_slot/utils/tools/file_importers.dart';

class AppearanceButton extends StatelessWidget {
  AppearanceButton(this.title,
      {required this.onTap, required this.icon, super.key});
  String title;
  VoidCallback onTap;
  IconData icon;

  @override
  Widget build(BuildContext context) => OnTap(
        onTap: onTap,
        child: Container(
          height: height(context) * 0.07,
          width: width(context) * 0.4,
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
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      );
}
