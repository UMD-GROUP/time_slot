import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class CreatePromoCodeDialog extends StatefulWidget {
  CreatePromoCodeDialog(
      {required this.amount,
      required this.discount,
      required this.restriction,
      super.key});

  TextEditingController discount;
  TextEditingController restriction;
  TextEditingController amount;

  @override
  State<CreatePromoCodeDialog> createState() => _CreatePromoCodeDialogState();
}

class _CreatePromoCodeDialogState extends State<CreatePromoCodeDialog> {
  bool isVisible = true;

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
                    controller: widget.discount,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    placeholder: 'discount'.tr,
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.23,
                  child: CupertinoTextField(
                    controller: widget.amount,
                    inputFormatters: [SevenDigitInputFormatter()],
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    placeholder: 'min_count'.tr,
                  ),
                ),
              ],
            ),
            SizedBox(height: height(context) * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width(context) * 0.23,
                  child: CupertinoTextField(
                    inputFormatters: [ThreeDigitInputFormatter()],
                    controller: widget.restriction,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    placeholder: 'restriction'.tr,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${'active'.tr}:',
                        style: AppTextStyles.labelLarge(context,
                            color: Colors.black)),
                    CupertinoCheckbox(
                      value: isVisible,
                      onChanged: (value) {
                        isVisible = value!;
                        setState(() {});
                      },
                    )
                  ],
                )
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
              if (widget.discount.text.isEmpty || widget.amount.text.isEmpty) {
                print(widget.discount.text);
                print(widget.amount.text);
              } else {
                Navigator.pop(context);
                context.read<PromoCodeBloc>().add(
                    CreateNewCodeEvent(
                        PromoCodeModel(
                            maxUsingLimit: widget.restriction.text.isEmpty
                                ? -8
                                : int.parse(widget.restriction.text),
                            isVisible: isVisible,
                            promoCode: generateUniquePromoCode(context
                                .read<PromoCodeBloc>()
                                .state
                                .promoCodes
                                .cast()),
                            docId: '',
                            discount: int.parse(widget.discount.text.trim()),
                            minAmount: int.parse(widget.amount.text.trim()),
                            usedOrders: [])));
              }
            },
            child: Text('confirm'.tr),
          ),
        ],
      );
}
