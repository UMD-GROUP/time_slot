// ignore_for_file: cascade_invocations

import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class OrderInfoBottomSheet extends StatelessWidget {
  OrderInfoBottomSheet({super.key, required this.order});

  OrderModel order;

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
        // title: Text(
        //   '${'order_detail'.tr}:',
        //   style: AppTextStyles.labelLarge(context,
        //       fontSize: 18, color: Colors.black),
        // ),
        message: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height(context) * 0.15,
              width: width(context),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.refresh,
                  height: height(context) * 0.05,
                ),
              ),
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderSheetItemWidget(
                    context: context,
                    text: 'accept',
                    color: Colors.yellow,
                    onTap: () {}),
                OrderSheetItemWidget(
                    context: context,
                    text: 'decline',
                    color: Colors.red,
                    onTap: () {}),
                OrderSheetItemWidget(
                    context: context,
                    text: 'finished',
                    color: Colors.green,
                    onTap: () {}),
                OrderSheetItemWidget(
                    context: context,
                    text: 'un_finished',
                    color: Colors.red,
                    onTap: () {}),

                // context: context,
                // text: 'Accept',
                // color: Colors.yellow,
                // onTap: () {
                //   showConfirmCancelDialog(
                //     context,
                //     () {
                //       order.status = OrderStatus.inProgress;
                //       context
                //           .read<AdminBloc>()
                //           .add(UpdateOrderEvent(order));
                //     },
                //   );
                // }),
//                 OrderSheetItemWidget(
//                     context: context,
//                     text: 'Decline',
//                     color: Colors.red,
//                     onTap: () {}),
//                 OrderSheetItemWidget(
//                     context: context,
//                     text: 'Finished',
//                     color: Colors.green,
//                     onTap: () {}),
//                 OrderSheetItemWidget(
//                     context: context,
//                     text: 'UnFinished',
//                     color: Colors.red,
//                     onTap: () {}),
              ],
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PurchaseTextWidget(
                      icon: AppIcons.check,
                      text1: 'order:',
                      text2: order.orderId.toString(),
                    ),
                    PurchaseTextWidget(
                      icon: AppIcons.basket,
                      text1: 'product_count',
                      text2: order.referallId.toString(),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  height: height(context) * 0.03,
                  width: width(context) * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                      child: Text(
                    'edit'.tr,
                    style: AppTextStyles.bodyMedium(context),
                  )),
                )
              ],
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            PurchaseTextWidget(
              icon: AppIcons.balance,
              text1: 'purchase',
              text2: order.sum.toString(),
            ),
            PurchaseTextWidget(
              icon: AppIcons.users,
              text1: 'partner',
              text2: order.dates.toString(),
            ),
            PurchaseTextWidget(
              icon: AppIcons.calendar,
              text1: 'created',
              text2: order.dates.toString(),
            ),
            PurchaseTextWidget(
              icon: AppIcons.check,
              text1: 'finished'.tr,
              text2: order.dates.toString(),
            ),
            Row(children: [
              Icon(
                Icons.info_outline,
                color: AdaptiveTheme.of(context).theme.canvasColor,
                size: height(context) * 0.025,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'status'.tr,
                style: AppTextStyles.bodyMedium(context),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                order.status.toString() == 'OrderStatus.created'
                    ? 'created'.tr
                    : order.status.toString() == 'OrderStatus.inProgress'
                        ? 'progress'.tr
                        : order.status.toString() == 'OrderStatus.cancelled'
                            ? 'cancelled'
                            : 'done',
                style: AppTextStyles.bodyLargeSmall(context,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: order.status == OrderStatus.created
                        ? Colors.yellow
                        : order.status.toString() == 'OrderStatus.inProgress'
                            ? AppColors.cGold
                            : order.status.toString() == 'OrderStatus.cancelled'
                                ? AppColors.cFF3333
                                : Colors.green),
              )
            ])
          ],
        ),
        // cancelButton: CupertinoActionSheetAction(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: const Text('Close'),
        // ),
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                final OrderModel order =
                    context.read<CreateOrderBloc>().state.order;
                order.referallId =
                    context.read<UserBloc>().state.user!.referallId;
                order.ownerId = context.read<UserBloc>().state.user!.uid;

                context.read<CreateOrderBloc>().add(
                    AddOrderEvent(order, context.read<UserBloc>().state.user!));
              },
              child: Text('confirm'.tr))
        ],
      );

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
          width: width(context) * 0.18,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10.r)),
          child: Center(
            child: Text(
              text.tr,
              style: AppTextStyles.bodyMedium(context, fontSize: 12.sp),
            ),
          ),
        ),
      );
}
