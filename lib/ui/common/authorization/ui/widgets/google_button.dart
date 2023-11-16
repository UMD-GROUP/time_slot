// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import '../../../../../utils/tools/file_importers.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({this.isSignIn = false, super.key});
  bool isSignIn;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: Platform.isAndroid,
        child: OnTap(
          onTap: () async {
            if (isSignIn) {
              context
                  .read<AuthorizationBloc>()
                  .add(CreateAccountWithGoogleEvent(true));
            } else {
              context
                  .read<AuthorizationBloc>()
                  .add(CreateAccountWithGoogleEvent(false));
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
        ),
      );
}
