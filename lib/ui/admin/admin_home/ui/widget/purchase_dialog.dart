import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class PurchaseDialog extends StatelessWidget {
  PurchaseDialog({required this.purchaseModel, super.key});
  PurchaseModel purchaseModel;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text('purchase_data'.tr),
        content: SizedBox(
          width: width(context) * 0.7,
          child: Column(
            children: [
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.balance,
                    color: AdaptiveTheme.of(context).theme.canvasColor,
                    height: height(context) * 0.03,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    'amount'.tr,
                    style: AppTextStyles.bodyMedium(context,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    purchaseModel.amount.toString(),
                    style: AppTextStyles.bodyMedium(context),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'uz_sum'.tr,
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.calendar,
                    color: AdaptiveTheme.of(context).theme.canvasColor,
                    height: height(context) * 0.03,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    'created'.tr,
                    style: AppTextStyles.bodyMedium(context,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    purchaseModel.createdAt.toUtc().toString().split(' ').first,
                    // purchaseModel..toString(),
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  Icon(
                    Icons.credit_card_outlined,
                    size: height(context) * 0.03,
                  ),
                  // SvgPicture.asset(
                  //   AppIcons.c,
                  //   color: AdaptiveTheme.of(context).theme.canvasColor,
                  //   height: height(context) * 0.03,
                  // ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    'banking_card'.tr,
                    style: AppTextStyles.bodyMedium(context,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      copyToClipboard(
                          context, purchaseModel.cardNumber.toString());
                    },
                    child: Text(
                      //      DateTime.parse(purchaseModel.cardNumber).toUtc().toString().split(' ').first,
                      purchaseModel.cardNumber.toString().length > 4
                          ? '${purchaseModel.cardNumber.toString().substring(0, 4)}***'
                          : purchaseModel.cardNumber.toString(),
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              if (purchaseModel.status != PurchaseStatus.finished)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OrderSheetItemWidget(
                        context: context,
                        text: 'accept',
                        color: Colors.yellow,
                        onTap: () {
                          showConfirmCancelDialog(context, () {
                            purchaseModel.status = PurchaseStatus.inProgress;
                            context
                                .read<AdminBloc>()
                                .add(UpdatePurchaseEvent(purchaseModel));
                          });
                        }),
                    OrderSheetItemWidget(
                        context: context,
                        text: 'finished',
                        color: Colors.green,
                        onTap: () {
                          showConfirmCancelDialog(context, () {
                            purchaseModel.status = PurchaseStatus.finished;
                            context
                                .read<AdminBloc>()
                                .add(UpdatePurchaseEvent(purchaseModel));
                          });
                        }),
                  ],
                ),
              if (purchaseModel.status != PurchaseStatus.finished)
                SizedBox(height: height(context) * 0.01),
              if (purchaseModel.status != PurchaseStatus.finished)
                OrderSheetItemWidget(
                    context: context,
                    text: 'decline',
                    color: Colors.red,
                    onTap: () {
                      showConfirmCancelDialog(context, () {
                        purchaseModel.status = PurchaseStatus.cancelled;
                        context
                            .read<AdminBloc>()
                            .add(UpdatePurchaseEvent(purchaseModel));
                      });
                    }),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('close'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
}

// ignore: non_constant_identifier_names
GestureDetector OrderSheetItemWidget(
        {required VoidCallback onTap,
        required BuildContext context,
        required String text,
        required Color color}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        height: height(context) * 0.04,
        width: width(context) * 0.2,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: Text(
            text.tr,
            style: AppTextStyles.bodyMedium(context,
                fontSize: 14.sp, color: Colors.black),
          ),
        ),
      ),
    );
