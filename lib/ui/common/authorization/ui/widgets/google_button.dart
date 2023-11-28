// ignore_for_file: use_build_context_synchronously

import 'package:time_slot/ui/user/orders/bloc/bloc/data_from_admin/data_from_admin_state.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../utils/tools/file_importers.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({this.isSignIn = false, super.key});
  bool isSignIn;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DataFromAdminBloc, DataFromAdminState>(
        builder: (context, state) => Visibility(
          visible: state.status == ResponseStatus.inSuccess,
          child: Visibility(
            visible: isSignIn
                ? state.data!.signInInstruction.isNotEmpty
                : state.data!.signUpInstruction.isNotEmpty,
            child: OnTap(
              onTap: () async {
                await launchUrlString(isSignIn
                    ? state.data!.signInInstruction
                    : state.data!.signUpInstruction);
              },
              child: Container(
                padding: EdgeInsets.all(12.h),
                width: width(context) * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.h),
                  // color: AdaptiveTheme.of(context).theme.hintColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      AppImages.youtube, // Provide your Google logo image asset
                      height: 36, // Adjust the height as needed
                    ),
                    const SizedBox(
                        width: 12), // Spacing between the icon and text
                    Text(
                      'instruction'.tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700, // Text color
                        fontSize: 20, // Text font size
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
