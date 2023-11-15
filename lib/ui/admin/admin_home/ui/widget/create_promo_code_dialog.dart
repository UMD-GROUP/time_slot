import 'package:flutter/cupertino.dart';
import 'package:time_slot/ui/admin/admin_home/bloc/promo_codes_bloc/promo_code_bloc.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class CreatePromoCodeDialog extends StatelessWidget {
  CreatePromoCodeDialog(
      {required this.amount, required this.discount, super.key});

  TextEditingController discount;
  TextEditingController amount;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text('new_promo_code'.tr),
        content: Column(
          children: [
            SizedBox(height: height(context) * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width(context) * 0.23,
                  child: CupertinoTextField(
                    inputFormatters: [ThreeDigitInputFormatter()],
                    controller: discount,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    placeholder: 'discount'.tr,
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.23,
                  child: CupertinoTextField(
                    controller: amount,
                    inputFormatters: [SevenDigitInputFormatter()],
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    placeholder: 'min_count'.tr,
                  ),
                ),
              ],
            )
          ],
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
            onPressed: () {
              if (discount.text.isEmpty || amount.text.isEmpty) {
                print(discount.text);
                print(amount.text);
              } else {
                Navigator.pop(context);
                context.read<PromoCodeBloc>().add(CreateNewCodeEvent(
                    PromoCodeModel(
                        promoCode: generateUniquePromoCode(context
                            .read<PromoCodeBloc>()
                            .state
                            .promoCodes
                            .cast()),
                        docId: '',
                        discount: int.parse(discount.text.trim()),
                        minAmount: int.parse(amount.text.trim()),
                        usedOrders: [])));
              }
            },
            child: Text('confirm'.tr),
          ),
        ],
      );
}
