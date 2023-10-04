import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class DeleteBannerDialog extends StatelessWidget {
  DeleteBannerDialog({required this.image, super.key});
  String image;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text('delete_banner'.tr),
        content: Text('are_you_sure_you_want_to_delete_this_banner'.tr),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true, // This makes the text red
            onPressed: () {
              context.read<AdminBloc>().add(RemoveBannerEvent(
                  image, context.read<DataFromAdminBloc>().state.data!));
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('delete'.tr),
          ),
        ],
      );
}
