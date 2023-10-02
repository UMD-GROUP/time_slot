import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AddPurchaseDialog extends StatelessWidget {
  AddPurchaseDialog({required this.controller, super.key});
  TextEditingController controller;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: const Text('Enter Money Amount'),
        content: CupertinoTextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          placeholder: 'min 50 000 UZS',
          onChanged: (value) {},
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              String error = '';
              if (int.parse(controller.text.trim()) < 50000) {
                error = 'you_need_to_enter_more_then_50'.tr;
              } else if (int.parse(controller.text.trim()) >
                  context.read<UserBloc>().state.user!.card.balance) {
                error = 'you_cant_afford'.tr;
              }
              if (error.isEmpty) {
                context.read<PurchaseBloc>().add(AddPurchaseEvent(PurchaseModel(
                    status: PurchaseStatus.created,
                    amount: int.parse(controller.text.trim()),
                    ownerId: context.read<UserBloc>().state.user!.uid,
                    purchaseId: 0,
                    referralId:
                        context.read<UserBloc>().state.user!.referallId)));
              } else {
                AnimatedSnackBar(
                  snackBarStrategy: RemoveSnackBarStrategy(),
                  builder: (context) => AppErrorSnackBar(text: error),
                ).show(context);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
}
