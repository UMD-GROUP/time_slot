import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class UpdateStoreDialog extends StatelessWidget {
  UpdateStoreDialog(
      {required this.id,
      required this.marketName,
      required this.store,
      super.key});
  TextEditingController id;
  TextEditingController marketName;
  StoreModel store;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text('update_store'.tr),
        content: Column(
          children: <Widget>[
            SizedBox(height: height(context) * 0.01),
            SizedBox(
              width: width(context) * 0.3,
              child: CupertinoTextField(
                controller: id,
                inputFormatters: [MaxLengthInputFormatter(8)],
                // controller: discount,
                maxLength: 8,
                keyboardType: TextInputType.number,
                placeholder: 'Id'.tr,
              ),
            ),
            SizedBox(height: height(context) * 0.01),
            SizedBox(
              width: width(context) * 0.4,
              child: CupertinoTextField(
                controller: marketName,
                placeholder: 'market_name'.tr,
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textStyle: const TextStyle(color: Colors.red),
            child: Text('cancel'.tr),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              store
                ..name = marketName.text.trim()
                ..id = id.text.trim();
              context.read<StoresBloc>().add(UpdateStoreEvent(
                  store,
                  context.read<UserAccountBloc>().state.user,
                  context.read<DataFromAdminBloc>().state.data!.freeLimit));
            },
            child: Text('confirm'.tr),
          ),
        ],
      );
}
