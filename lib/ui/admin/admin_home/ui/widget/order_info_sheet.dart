// ignore_for_file: cascade_invocations, use_build_context_synchronously

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
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
  Widget build(BuildContext context) {
    final OrderStatus lastStatus = widget.order.status;
    final bool isCancelled = !widget.isAdmin &&
        widget.order.ownerId ==
            context.read<UserAccountBloc>().state.user.uid &&
        widget.order.status == OrderStatus.cancelled;
    final bool isAbleToEdit = widget.order.status != OrderStatus.done &&
            widget.order.status != OrderStatus.cancelled &&
            widget.isAdmin ||
        widget.order.status == OrderStatus.cancelled && widget.isAdmin;
    return CupertinoActionSheet(
      title: Text(
        '${'order_detail'.tr}:',
        style: AppTextStyles.labelLarge(
          context,
          fontSize: 18.sp,
        ),
      ),
      actions: [
        if (widget.isAdmin)
          CupertinoActionSheetAction(onPressed: () {}, child: Text('edit'.tr)),
        if (isCancelled)
          CupertinoActionSheetAction(
              onPressed: () async {
                copyToClipboard(context, makeReport(widget.order));
                await launch('https://t.me/Timeslot_admin');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.telegram),
                  SizedBox(width: width(context) * 0.05),
                  Text('by_telegram'.tr,
                      style: AppTextStyles.labelLarge(context))
                ],
              )),
        if (false)
          CupertinoActionSheetAction(
              onPressed: () async {
                await sendSMSTo(makeReport(widget.order));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.sms),
                  SizedBox(width: width(context) * 0.05),
                  Text("Sms jo'natish",
                      style: AppTextStyles.labelLarge(context))
                ],
              )),
        if (isCancelled)
          CupertinoActionSheetAction(
              onPressed: () async {
                await FlutterPhoneDirectCaller.callNumber('+998900387095');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.call),
                  SizedBox(width: width(context) * 0.05),
                  Text('call'.tr, style: AppTextStyles.labelLarge(context))
                ],
              )),
      ],
      message: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.isAdmin ||
                  context.read<UserAccountBloc>().state.user!.uid ==
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
            visible: isAbleToEdit,
            child: Column(
              children: [
                SizedBox(
                  height: height(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.order.status != OrderStatus.inProgress)
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
                                      .maxLimit
                                      .toInt(),
                                  lastStatus));
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
                                      .maxLimit
                                      .toInt(),
                                  lastStatus));
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
                                      .maxLimit
                                      .toInt(),
                                  lastStatus,
                                  photo: photo!.path));
                            });
                          }),
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
                              context.read<UserAccountBloc>().state.user!.uid ||
                      widget.isAdmin)
                    RowText(
                      icon: AppIcons.basket,
                      text1: 'product_count',
                      text2:
                          '${widget.order.products.fold(0, (previousValue, element) => previousValue + int.parse(element.count.toString()))} ${'piece'.tr}',
                    ),
                ],
              ),
            ],
          ),
          if (widget.isAdmin ||
              widget.order.ownerId ==
                  context.read<UserAccountBloc>().state.user!.uid)
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
          if (widget.isAdmin ||
              widget.order.ownerId ==
                  context.read<UserAccountBloc>().state.user!.uid)
            RowText(
              icon: AppIcons.calendar,
              text1: 'date'.tr,
              text2: '${widget.order.date}',
            ),
          RowText(
            icon: AppIcons.balance,
            text1: 'payment',
            text2: '${widget.order.totalSum.toInt()} UZS',
          ),
          RowText(
            icon: AppIcons.users,
            text1: '${'partners'.tr}:',
            text2: widget.order.referralId.toString(),
          ),
          RowText(
            isVisible: widget.isAdmin ||
                widget.order.ownerId ==
                    context.read<UserAccountBloc>().state.user!.uid,
            icon: AppIcons.shop,
            text1: '${'market_name'.tr}:',
            text2: widget.order.marketName.length > 10
                ? widget.order.marketName.substring(0, 10)
                : widget.order.marketName,
          ),
          RowText(
            icon: AppIcons.calendar,
            text1: '${'created'.tr}:',
            text2: dateTimeToFormat(
                DateTime.parse(widget.order.createdAt.toString())),
          ),
          Visibility(
            visible: widget.order.status == OrderStatus.done,
            child: RowText(
              icon: AppIcons.check,
              text1: '${'finished'.tr}:',
              text2: dateTimeToFormat(widget.order.finishedAt),
            ),
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
            ),
          ]),
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
