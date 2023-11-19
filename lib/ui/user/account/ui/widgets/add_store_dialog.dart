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
                Text('don_not_forget_to_add_number'
                    .trParams({'number': user.marketNumber})),
              TextButton(
                  onPressed: () {
                    launchUrlString(context
                        .read<DataFromAdminBloc>()
                        .state
                        .data!
                        .addStaffVideo);
                  },
                  child: Text(
                    'add_staff'.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelLarge(context, color: Colors.red),
                  )),
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
