// ignore_for_file: use_build_context_synchronously

import 'package:time_slot/ui/user/membership/data/models/banking_card_model.dart';

import '../../../../../utils/tools/file_importers.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({this.isSignIn = false, super.key});
  bool isSignIn;

  @override
  Widget build(BuildContext context) => OnTap(
        onTap: () async {
          final User? user = await handleSignIn();
          final UserModel userModel = UserModel(
              email: user?.email ?? '',
              password: '12345678',
              uid: user!.uid,
              token: generateToken(),
              createdAt: DateTime.now(),
              referallId: 'ADMIN2023',
              card: BankingCardModel(
                cardNumber: '',
              ));
          if (isSignIn) {
            context
                .read<AuthorizationBloc>()
                .add(CreateAccountWithGoogleEvent(userModel, true));
          } else {
            context
                .read<AuthorizationBloc>()
                .add(CreateAccountWithGoogleEvent(userModel, false));
          }
        },
        child: Container(
          padding: EdgeInsets.all(12.h),
          width: width(context) * 0.6,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.h),
            // color: AdaptiveTheme.of(context).theme.hintColor
          ),
          child: Row(
            children: <Widget>[
              Image.asset(
                AppImages.google, // Provide your Google logo image asset
                height: 36, // Adjust the height as needed
              ),
              const SizedBox(width: 12), // Spacing between the icon and text
              Text(
                'sign_in_with_google'.tr,
                style: TextStyle(
                  color: Colors.black, // Text color
                  fontSize: 18.sp, // Text font size
                ),
              ),
            ],
          ),
        ),
      );
}
