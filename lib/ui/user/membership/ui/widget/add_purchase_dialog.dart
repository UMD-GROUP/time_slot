import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AddPurchaseDialog extends StatelessWidget {
  AddPurchaseDialog({required this.controller, super.key});
  TextEditingController controller;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text('enter_money_amount'.tr),
        content: CupertinoTextField(
          //inputFormatters: [MoneyInputFormatter()],
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          placeholder: 'min 50 000 UZS',
          onChanged: (value) {},
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
            child: Text('ok'.tr),
            onPressed: () {
              String error = '';
              print(controller.text.trim().replaceAll(' ', ''));
              if (int.parse(controller.text.trim().replaceAll(' ', '')) <
                  50000) {
                error = 'you_need_to_enter_more_then_50'.tr;
              } else if (int.parse(controller.text.trim()) >
                  context.read<UserBloc>().state.user!.card.balance) {
                error = 'you_cant_afford'.tr;
              }
              if (error.isEmpty) {
                context.read<PurchaseBloc>().add(AddPurchaseEvent(
                    PurchaseModel(
                        status: PurchaseStatus.created,
                        amount: int.parse(controller.text.trim()),
                        ownerId: context.read<UserBloc>().state.user!.uid,
                        purchaseId: generateRandomID(false),
                        referralId:
                            context.read<UserBloc>().state.user!.referallId),
                    context.read<UserBloc>().state.user!));
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
