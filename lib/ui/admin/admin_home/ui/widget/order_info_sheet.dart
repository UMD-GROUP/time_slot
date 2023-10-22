// ignore_for_file: cascade_invocations, use_build_context_synchronously

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class OrderInfoBottomSheet extends StatefulWidget {
  OrderInfoBottomSheet({super.key, this.isAdmin = true, required this.order});
  bool isAdmin;

  OrderModel order;

  @override
  State<OrderInfoBottomSheet> createState() => _OrderInfoBottomSheetState();
}

class _OrderInfoBottomSheetState extends State<OrderInfoBottomSheet> {
  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
        title: Text(
          '${'order_detail'.tr}:',
          style: AppTextStyles.labelLarge(
            context,
            fontSize: 18.sp,
          ),
        ),
        actions: widget.isAdmin
            ? [
                CupertinoActionSheetAction(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('update'.tr))
              ]
            : null,
        message: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.isAdmin ||
                    context.read<UserBloc>().state.user!.uid ==
                        widget.order.ownerId
                ? OnTap(
                    onTap: () {
                      final imageProvider =
                          Image.network(widget.order.userPhoto).image;
                      showImageViewer(context, imageProvider,
                          onViewerDismissed: () {
                        print('dismissed');
                      });
                    },
                    child: Container(
                      height: height(context) * 0.15,
                      width: width(context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.order.userPhoto),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                  )
                : const SizedBox(),
            Visibility(
              visible: widget.order.status != OrderStatus.done &&
                      widget.order.status != OrderStatus.cancelled &&
                      widget.isAdmin ||
                  widget.order.status == OrderStatus.cancelled &&
                      widget.isAdmin,
              child: Column(
                children: [
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
                              widget.order.status = OrderStatus.inProgress;
                              context.read<AdminBloc>().add(UpdateOrderEvent(
                                  widget.order,
                                  context
                                      .read<DataFromAdminBloc>()
                                      .state
                                      .data!
                                      .partnerPercent
                                      .toInt()));
                            });
                          }),
                      if (widget.order.status == OrderStatus.inProgress &&
                          widget.isAdmin)
                        OrderSheetItemWidget(
                            context: context,
                            text: 'decline',
                            color: Colors.red,
                            onTap: () async {
                              final TextEditingController comment =
                                  TextEditingController();
                              comment.text = widget.order.comment;
                              showTextInputDialog(context, onConfirmTapped: () {
                                widget.order.status = OrderStatus.cancelled;
                                widget.order.comment = comment.text;
                                context.read<AdminBloc>().add(UpdateOrderEvent(
                                    widget.order,
                                    context
                                        .read<DataFromAdminBloc>()
                                        .state
                                        .data!
                                        .partnerPercent
                                        .toInt()));
                              },
                                  controller: comment,
                                  title: 'add_comment'.tr,
                                  hintText: ' ');
                            }),
                      if (widget.order.status == OrderStatus.inProgress &&
                          widget.isAdmin)
                        OrderSheetItemWidget(
                            context: context,
                            text: 'finished',
                            color: Colors.green,
                            onTap: () {
                              showConfirmCancelDialog(context, () async {
                                widget.order.status = OrderStatus.done;
                                final XFile? photo = await showPicker(context);
                                context.read<AdminBloc>().add(UpdateOrderEvent(
                                    widget.order,
                                    context
                                        .read<DataFromAdminBloc>()
                                        .state
                                        .data!
                                        .partnerPercent
                                        .toInt(),
                                    photo: photo!.path));
                              });
                            }),
                      // OrderSheetItemWidget(
                      //     context: context,
                      //     text: 'un_finished',
                      //     color: Colors.red,
                      //     onTap: () {}),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowText(
                      icon: AppIcons.check,
                      text1: 'order_id'.tr,
                      text2: widget.order.orderId.toString(),
                    ),
                    if (!widget.isAdmin &&
                            widget.order.ownerId ==
                                context.read<UserBloc>().state.user!.uid ||
                        widget.isAdmin)
                      RowText(
                        icon: AppIcons.basket,
                        text1: 'product_count',
                        text2:
                            '${widget.order.products.fold(0, (previousValue, element) => previousValue + int.parse(element.count.toString()))} ${'piece'.tr}',
                      ),
                  ],
                ),
                const Spacer(),
                Visibility(
                  visible: widget.order.status != OrderStatus.done &&
                      widget.order.status != OrderStatus.cancelled &&
                      widget.isAdmin,
                  child: OnTap(
                    onTap: () {
                      showEditProductsBottomSheet(context, widget.order);
                    },
                    child: Container(
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
                    ),
                  ),
                )
              ],
            ),
            if (widget.isAdmin ||
                widget.order.ownerId ==
                    context.read<UserBloc>().state.user!.uid)
              ...List.generate(widget.order.products.length, (index) {
                final List<ProductModel> pducts = widget.order.products.cast();
                return Padding(
                  padding: EdgeInsets.only(left: width(context) * 0.04),
                  child: Text(
                    '${index + 1}. ${pducts[index].deliveryNote} - ${pducts[index].count} ${'piece'.tr}',
                    style: AppTextStyles.bodyMedium(
                      context,
                      fontSize: 15.sp,
                    ),
                  ),
                );
              }),
            // PurchaseTextWidget(
            //   icon: AppIcons.calendar,
            //   text1: 'day_count',
            //   text2: '${widget.order.dates.length} ${'piece'.tr}',
            // ),
            if (widget.isAdmin ||
                widget.order.ownerId ==
                    context.read<UserBloc>().state.user!.uid)
              Wrap(
                spacing: 4.w, // Horizontal spacing between items
                runSpacing: 5.h, //

                children: List.generate(
                    widget.order.dates.length,
                    (index) => Padding(
                          padding: EdgeInsets.only(left: width(context) * 0.04),
                          child: Text(
                            DateTime.parse(widget.order.dates[index])
                                .toUtc()
                                .toString()
                                .split(' ')
                                .first,
                            style: AppTextStyles.bodyMedium(context,
                                fontSize: 15.sp),
                          ),
                        )),
              ),
            // PurchaseTextWidget(
            //   icon: AppIcons.balance,
            //   text1: 'payment',
            //   text2: '${widget.order.sum.toInt()} UZS',
            // ),
            // PurchaseTextWidget(
            //   icon: AppIcons.users,
            //   text1: '${'partners'.tr}:',
            //   text2: widget.order.referallId.toString(),
            // ),
            // PurchaseTextWidget(
            //   isVisible: widget.isAdmin ||
            //       widget.order.ownerId ==
            //           context.read<UserBloc>().state.user!.uid,
            //   icon: AppIcons.shop,
            //   text1: '${'market_name'.tr}:',
            //   text2: widget.order.marketName.length > 10
            //       ? widget.order.marketName.substring(0, 10)
            //       : widget.order.marketName,
            // ),
            // PurchaseTextWidget(
            //   icon: AppIcons.calendar,
            //   text1: '${'created'.tr}:',
            //   text2: dateTimeToFormat(
            //       DateTime.parse(widget.order.createdAt.toString())),
            // ),
            // Visibility(
            //   visible: widget.order.status == OrderStatus.done,
            //   child: PurchaseTextWidget(
            //     icon: AppIcons.check,
            //     text1: '${'finished'.tr}:',
            //     text2: dateTimeToFormat(widget.order.finishedAt),
            //   ),
            // ),
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
                widget.order.status.toString() == 'OrderStatus.created'
                    ? 'created'.tr
                    : widget.order.status.toString() == 'OrderStatus.inProgress'
                        ? 'progress'.tr
                        : widget.order.status.toString() ==
                                'OrderStatus.cancelled'
                            ? 'cancelled'.tr
                            : 'done'.tr,
                style: AppTextStyles.bodyLargeSmall(context,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: widget.order.status == OrderStatus.created
                        ? Colors.yellow
                        : widget.order.status.toString() ==
                                'OrderStatus.inProgress'
                            ? AppColors.cGold
                            : widget.order.status.toString() ==
                                    'OrderStatus.cancelled'
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
