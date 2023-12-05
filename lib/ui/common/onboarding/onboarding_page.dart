import 'package:time_slot/ui/common/onboarding/widgets/onboarding_text.dart';
import 'package:time_slot/ui/user/account/ui/widgets/appearance_button.dart';

import '../../../utils/tools/file_importers.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isUzbek = 'light_mode'.tr == 'Kunduzgi rejim';
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.h),
          width: width(context),
          height: height(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppearanceButton(isUzbek ? 'uzbek' : 'russian',
                  isOnBoard: true, onTap: changeLanguage, icon: Icons.language),
              SizedBox(height: height(context) * 0.02),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    border: Border.all(color: Colors.deepPurpleAccent)),
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.warning_amber,
                          color: Colors.red,
                        ),
                        Text('onboarding_title'.tr,
                            style:
                                AppTextStyles.labelSBold(context, fontSize: 18))
                      ],
                    ),
                    SizedBox(height: height(context) * 0.02),
                    OnBoardingText(title: 'onboarding_1'),
                    OnBoardingText(title: 'onboarding_2'),
                    OnBoardingText(title: 'onboarding_3'),
                    SizedBox(height: height(context) * 0.02),
                    OnBoardingText(title: 'onboarding_4'),
                  ],
                ),
              ),
              SizedBox(height: height(context) * 0.01),
              AppearanceButton('start', isOnBoard: true, onTap: () {
                getIt<StorageService>().saveBool('isPassed', true);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteName.userMain, (route) => false);
              }, icon: Icons.start),
            ],
          ),
        ),
      ),
    );
  }
}
