import 'package:time_slot/ui/user/account/ui/widgets/appearance.dart';
import 'package:time_slot/ui/user/account/ui/widgets/user_stores.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('User Account'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              children: [
                const Appearance(),
                SizedBox(height: height(context) * 0.02),
                const UserStores(),
                GestureDetector(
                  onTap: () {
                    copyToClipboard(context, 'some');
                  },
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${'referral'.tr}       ',
                          style: AppTextStyles.labelLarge(context,
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        TextSpan(
                          style: AppTextStyles.labelLarge(context),
                          text:
                              'somefdfdsfds', // Empty text to ensure the whole text is selectable
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.adminHome);
          },
        ),
      );
}
