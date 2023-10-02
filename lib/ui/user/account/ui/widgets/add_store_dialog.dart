import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

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
              Text('enter_your_stores_name_and_add'.tr),
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
