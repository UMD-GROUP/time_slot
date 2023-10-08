// ignore_for_file: cascade_invocations

import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class OrderInfoBottomSheet extends StatelessWidget {
  OrderInfoBottomSheet({super.key, required this.order});

  OrderModel order;

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
        title: Text(
          '${'order_detail'.tr}:',
          style: AppTextStyles.labelLarge(context,
              fontSize: 18, color: Colors.black),
        ),
        message: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height(context) * 0.15,
              width: width(context),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(order.userPhoto), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10.r)),
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
                    onTap: () {
                      showConfirmCancelDialog(context, () {
                        order.status = OrderStatus.inProgress;
                        context.read<AdminBloc>().add(UpdateOrderEvent(order));
                      });
                    }),
                OrderSheetItemWidget(
                    context: context,
                    text: 'decline',
                    color: Colors.red,
                    onTap: () {
                      showConfirmCancelDialog(context, () {
                        order.status = OrderStatus.cancelled;
                        context.read<AdminBloc>().add(UpdateOrderEvent(order));
                      });
                    }),
                OrderSheetItemWidget(
                    context: context,
                    text: 'finished',
                    color: Colors.green,
                    onTap: () {
                      showConfirmCancelDialog(context, () {
                        order.status = OrderStatus.done;
                        context.read<AdminBloc>().add(UpdateOrderEvent(order));
                      });
                    }),
                // OrderSheetItemWidget(
                //     context: context,
                //     text: 'un_finished',
                //     color: Colors.red,
                //     onTap: () {}),
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
                      text1: 'order:'.tr,
                      text2: order.orderId.toString(),
                    ),
                    PurchaseTextWidget(
                      icon: AppIcons.basket,
                      text1: 'product_count',
                      text2: order.products.length.toString(),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  height: height(context) * 0.03,
                  width: width(context) * 0.2,
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
            ...List.generate(order.products.length, (index) {
              final List<ProductModel> pducts = order.products.cast();
              return Padding(
                padding: EdgeInsets.only(left: width(context) * 0.08),
                child: Text(
                  '${index + 1}. ${pducts[index].deliveryNote} - ${pducts[index].count} ${'piece'.tr}',
                  style: AppTextStyles.bodyMedium(context,
                      fontSize: 15.sp, color: Colors.black),
                ),
              );
            }),
            PurchaseTextWidget(
              icon: AppIcons.calendar,
              text1: 'day_count',
              text2: '${order.dates.length} ${'piece'.tr}',
            ),
            SizedBox(
              width: width(context),
              height: height(context) * (0.03 * (order.dates.length % 3)),
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 3, childAspectRatio: 2 / 3),
                  itemCount: order.dates.length,
                  itemBuilder: (context, index) {
                    print(order.dates.length);
                    return Text(
                      DateTime.parse(order.dates[index])
                          .toUtc()
                          .toString()
                          .split(' ')
                          .first,
                      style: AppTextStyles.bodyMedium(context,
                          fontSize: 15.sp, color: Colors.black),
                    );
                  }),
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            PurchaseTextWidget(
              icon: AppIcons.balance,
              text1: 'payment',
              text2: order.sum.toString(),
            ),
            PurchaseTextWidget(
              icon: AppIcons.users,
              text1: '${'partners'.tr}:',
              text2: order.referallId.toString(),
            ),
            PurchaseTextWidget(
              icon: AppIcons.calendar,
              text1: '${'created'.tr}:',
              text2: 'mock_data',
            ),
            PurchaseTextWidget(
              icon: AppIcons.check,
              text1: '${'finished'.tr}:',
              text2: 'mock_data',
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
                style: AppTextStyles.bodyMedium(context,
                    fontWeight: FontWeight.bold),
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
                            ? 'cancelled'.tr
                            : 'done'.tr,
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
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'close'.tr,
            style: const TextStyle(color: Colors.red),
          ),
        ),
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
              style: AppTextStyles.bodyMedium(context,
                  fontSize: 12.sp, color: Colors.black),
            ),
          ),
        ),
      );
}
