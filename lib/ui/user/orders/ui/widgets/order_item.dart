import 'package:time_slot/ui/user/orders/ui/widgets/order_text_widget.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class OrderItem extends StatelessWidget {
  OrderItem({required this.order, super.key});
  OrderModel order;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 5.w),
        child: Container(
            height: height(context) * 0.15,
            width: width(context),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.3, color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                SizedBox(
                  height: height(context) * 0.14,
                  width: width(context) * 0.35,
                  child: CachedNetworkImage(
                    imageUrl: order.userPhoto,
                    placeholder: (context, url) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        child: CustomShimmer(
                            child: Container(
                          height: height(context),
                          width: width(context),
                          decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ))),
                    imageBuilder: (context, imageProvider) => Container(
                      width: width(context),
                      margin: EdgeInsets.symmetric(horizontal: 5.h),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    OrderTextWidget(
                        context: context,
                        type: 'Order id:',
                        value: order.orderId.toString()),
                    OrderTextWidget(
                        context: context,
                        type: 'product count:',
                        value: order.products.length.toString()),
                    OrderTextWidget(
                        context: context,
                        type: 'sum',
                        value: order.sum.toString()),
                    OrderTextWidget(
                        context: context,
                        type: 'Partner id:',
                        value: order.referallId.toString()),
                    //     OrderTextWidget(context: context, type: 'Status:',value: data[index].status.toString()),
                    Row(
                      children: [
                        Text(
                          'Status:'.tr,
                          style: AppTextStyles.bodyMedium(context,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          order.status.toString() == 'OrderStatus.created'
                              ? 'created'.tr
                              : order.status.toString() ==
                                      'OrderStatus.inProgress'
                                  ? 'progress'.tr
                                  : order.status.toString() ==
                                          'OrderStatus.cancelled'
                                      ? 'cancelled'
                                      : 'done',
                          style: AppTextStyles.bodyLargeSmall(context,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              color: order.status == OrderStatus.created
                                  ? Colors.yellow
                                  : order.status.toString() ==
                                          'OrderStatus.inProgress'
                                      ? AppColors.cGold
                                      : order.status.toString() ==
                                              'OrderStatus.cancelled'
                                          ? AppColors.cFF3333
                                          : Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            )),
      );
}
