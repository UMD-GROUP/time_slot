import 'package:get/get.dart';
import 'package:time_slot/ui/user/account/ui/widgets/appearance_button.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class Appearance extends StatelessWidget {
  const Appearance({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLight =
        AdaptiveTheme.of(context).theme.backgroundColor == Colors.white;
    final bool isUzbek = 'light_mode'.tr == 'Kunduzgi rejim';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppearanceButton(isUzbek ? 'uzbek' : 'russian', onTap: () {
          Get.updateLocale(
              isUzbek ? const Locale('ru', 'RU') : const Locale('uz', 'UZ'));
        }, icon: Icons.language),
        AppearanceButton(
          isLight ? 'light_mode' : 'dark_mode',
          icon: isLight ? Icons.light_mode : Icons.dark_mode,
          onTap: () {
            if (isLight) {
              AdaptiveTheme.of(context).setDark();
            } else {
              AdaptiveTheme.of(context).setLight();
            }
          },
        ),
      ],
    );
  }
}
