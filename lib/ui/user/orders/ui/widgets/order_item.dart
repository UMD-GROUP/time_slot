import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/order_info_sheet.dart';
import 'package:time_slot/ui/user/orders/ui/widgets/order_text_widget.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class OrderItem extends StatelessWidget {
  OrderItem({required this.order, super.key, required this.isAdmin});
  OrderModel order;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) => OnTap(
        onTap: () {
          showCupertinoModalPopup(
              context: context,
              builder: (context) => Theme(
                    data: AdaptiveTheme.of(context).theme.backgroundColor ==
                            Colors.white
                        ? ThemeData.light()
                        : ThemeData.dark(),
                    child: OrderInfoBottomSheet(
                      isAdmin: isAdmin,
                      order: order,
                    ),
                  ));
        },
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 5.w),
          child: Container(
              height: height(context) * 0.16,
              width: width(context),
              decoration: BoxDecoration(
                  color: AdaptiveTheme.of(context).theme.disabledColor,
                  border: Border.all(width: 0.3, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SizedBox(
                    height: height(context) * 0.14,
                    width: height(context) * 0.15,
                    child: (isAdmin && order.userPhoto.isNotEmpty) ||
                            (!isAdmin && order.adminPhoto.isNotEmpty)
                        ? OnTap(
                            onTap: () {
                              final imageProvider = Image.network(isAdmin
                                      ? order.userPhoto
                                      : order.adminPhoto)
                                  .image;
                              showImageViewer(context, imageProvider,
                                  onViewerDismissed: () {
                                print('dismissed');
                              });
                            },
                            child: CachedNetworkImage(
                              imageUrl:
                                  isAdmin ? order.userPhoto : order.adminPhoto,
                              placeholder: (context, url) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.h),
                                  child: CustomShimmer(
                                      child: Container(
                                    height: height(context),
                                    width: width(context),
                                    decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ))),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: width(context),
                                margin: EdgeInsets.symmetric(horizontal: 5.h),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.h),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: height(context) * 0.14,
                            width: width(context),
                            margin: EdgeInsets.symmetric(horizontal: 5.h),
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.h))),
                            child: Center(
                              child: SvgPicture.asset(
                                AppIcons.refresh,
                                height: 36.h,
                                color: Colors.black,
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
                          icon: Icons.install_desktop,
                          context: context,
                          type: 'ID:',
                          value: order.orderId.toString()),
                      OrderTextWidget(
                          icon: Icons.production_quantity_limits_sharp,
                          context: context,
                          type: 'product count:',
                          value:
                              '${order.products.fold(0, (previousValue, element) => int.parse((previousValue + element.count).toString()))} ${'piece'.tr}'),
                      OrderTextWidget(
                          icon: Icons.attach_money,
                          context: context,
                          type: 'sum',
                          value: '${order.sum.toInt()} UZS'),
                      OrderTextWidget(
                          icon: Icons.group,
                          context: context,
                          type: 'partner_id',
                          value: order.referallId.toString()),
                      //     OrderTextWidget(context: context, type: 'Status:',value: data[index].status.toString()),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.access_time_filled_outlined,
                                color:
                                    AdaptiveTheme.of(context).theme.hoverColor),
                            SizedBox(width: width(context) * 0.02),
                            Text(
                              'Status:'.tr,
                              style: AppTextStyles.bodyMedium(context,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            SizedBox(
                              width: width(context) * 0.3,
                              child: Text(
                                order.status.toString() == 'OrderStatus.created'
                                    ? 'created'.tr
                                    : order.status.toString() ==
                                            'OrderStatus.inProgress'
                                        ? 'progress'.tr
                                        : order.status.toString() ==
                                                'OrderStatus.cancelled'
                                            ? order.ownerId ==
                                                        context
                                                            .read<UserBloc>()
                                                            .state
                                                            .user!
                                                            .uid ||
                                                    isAdmin
                                                ? order.comment
                                                : 'cancelled'.tr
                                            : 'done'.tr,
                                maxLines: 3,
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height(context) * 0.01,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  )
                ],
              )),
        ),
      );
}
