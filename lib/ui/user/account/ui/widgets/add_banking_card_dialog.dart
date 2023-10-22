// // ignore_for_file: cascade_invocations
//
// import 'package:flutter/cupertino.dart';
// import 'package:time_slot/utils/tools/file_importers.dart';
//
// class AddBankingCardDialog extends StatelessWidget {
//   AddBankingCardDialog({required this.controller, super.key});
//   TextEditingController controller;
//
//   @override
//   Widget build(BuildContext context) => CupertinoAlertDialog(
//         title: Text('add_your_banking_card'.tr),
//         content: Container(
//           margin: EdgeInsets.only(top: 12.h),
//           child: CupertinoTextField(
//             autofocus: true,
//             inputFormatters: [CardNumberInputFormatter()],
//             controller: controller,
//             keyboardType: const TextInputType.numberWithOptions(decimal: true),
//             placeholder: '1111 1111 1111 1111',
//             onChanged: (value) {},
//           ),
//         ),
//         actions: <Widget>[
//           CupertinoDialogAction(
//             textStyle: const TextStyle(color: Colors.red),
//             child: Text('cancel'.tr),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           CupertinoDialogAction(
//             child: Text('ok'.tr),
//             onPressed: () {
//               String error = '';
//               if (controller.text.length != 16) {
//                 error = 'invalid_card_number'.tr;
//               }
//               if (error.isEmpty) {
//                 final BankingCardModel card =
//                     context.read<UserBloc>().state.user!.card;
//                 card.cardNumber = controller.text.trim();
//                 context.read<UserAccountBloc>().add(AddBankingCardEvent(card));
//               } else {
//                 AnimatedSnackBar(
//                   snackBarStrategy: RemoveSnackBarStrategy(),
//                   builder: (context) => AppErrorSnackBar(text: error),
//                 ).show(context);
//               }
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
// }
