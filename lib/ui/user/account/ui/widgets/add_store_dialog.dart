import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AddStoreDialog extends StatelessWidget {
  AddStoreDialog({required this.user, super.key});
  UserModel user;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UserAccountBloc, UserAccountState>(
        builder: (context, state) => CupertinoAlertDialog(
          title: Text('add_your_store'.tr),
          content: Column(
            children: <Widget>[
              if (!context.read<DataFromAdminBloc>().state.data.isNull)
                Text('add_market_info'.trParams({'email': user.phoneNumber})),
              SizedBox(height: height(context) * 0.01),
              OnTap(
                onTap: () {
                  launchUrlString(context
                      .read<DataFromAdminBloc>()
                      .state
                      .data!
                      .addStaffVideo);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      AppImages.youtube, // Provide your Google logo image asset
                      height: 24, // Adjust the height as needed
                    ),
                    const SizedBox(
                        width: 12), // Spacing between the icon and text
                    Text(
                      'instruction'.tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600, // Text color
                        fontSize: 16, // Text font size
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: controller,
                placeholder: 'enter_store_name'.tr,
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('cancel'.tr),
            ),
            CupertinoDialogAction(
              onPressed: () {
                context
                    .read<UserAccountBloc>()
                    .add(AddMarketEvent(user, controller.text.trim()));
                Navigator.pop(context); // Close the dialog
              },
              child: Text('add'.tr),
            ),
          ],
        ),
      );
}
