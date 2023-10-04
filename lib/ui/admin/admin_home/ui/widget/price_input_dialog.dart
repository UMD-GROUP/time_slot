import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class PriceInputDialog extends StatelessWidget {
  PriceInputDialog(
      {required this.priceController, required this.onDoneTap, super.key});
  VoidCallback onDoneTap;
  TextEditingController priceController;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: const Text('Enter Price'),
        content: CupertinoTextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          placeholder: 'Enter price (max: 9999)',
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            textStyle: const TextStyle(color: Colors.red),
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            onPressed: onDoneTap,
            child: Text('confirm'.tr),
          ),
        ],
      );
}
