// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text('logging_out'.tr),
        content: Text('are_you_sure_you_want_to_logout'.tr),
        actions: <Widget>[
          CupertinoDialogAction(
            textStyle: const TextStyle(color: Colors.red),
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          CupertinoDialogAction(
            child: Text('yes'.tr),
            onPressed: () {
              Navigator.of(context).pop();
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.authorization, (route) => false);
            },
          ),
        ],
      );
}

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text('delete_account'.tr),
        content: Text('are_you_sure_you_want_to_delete_your_account'.tr),
        actions: <Widget>[
          CupertinoDialogAction(
            textStyle: const TextStyle(color: Colors.red),
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          CupertinoDialogAction(
            child: Text('yes'.tr),
            onPressed: () {
              Navigator.of(context).pop();
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.authorization, (route) => false);
            },
          ),
        ],
      );
}
