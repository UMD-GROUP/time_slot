import 'package:time_slot/ui/user/account/ui/widgets/appearance_button.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class Appearance extends StatelessWidget {
  const Appearance({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppearanceButton('language', onTap: () {}, icon: Icons.language),
          AppearanceButton(
            'light_mode',
            icon: Icons.light_mode,
            onTap: () {
              if (AdaptiveTheme.of(context).theme.backgroundColor ==
                  Colors.white) {
                AdaptiveTheme.of(context).setDark();
              } else {
                AdaptiveTheme.of(context).setLight();
              }
            },
          ),
        ],
      );
}
