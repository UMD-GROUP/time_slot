import 'package:flutter/cupertino.dart';
import 'package:time_slot/ui/admin/admin_home/ui/widget/user_stores_widget.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class UserInfoPopUp extends StatefulWidget {
  UserInfoPopUp({required this.user, super.key});
  UserModel user;

  @override
  State<UserInfoPopUp> createState() => _UserInfoPopUpState();
}

class _UserInfoPopUpState extends State<UserInfoPopUp> {
  @override
  Widget build(BuildContext context) => BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state.userUpdatingStatus == ResponseStatus.inSuccess) {
            setState(() {});
          }
        },
        child: CupertinoActionSheet(
          title: Text('user_data'.tr),
          message: SizedBox(
            width: width(context) * 0.7,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_2_outlined,
                      size: height(context) * 0.03,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'User:',
                      style: AppTextStyles.bodyMedium(context,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      widget.user.token,
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.users,
                      color: AdaptiveTheme.of(context).theme.canvasColor,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'Partner:',
                      style: AppTextStyles.bodyMedium(
                        context,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      widget.user.referallId,
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.check,
                      color: AdaptiveTheme.of(context).theme.canvasColor,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'orders'.tr,
                      style: AppTextStyles.bodyMedium(context,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ':',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '${widget.user.orders.length} ${'piece'.tr}',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 2.h),
                    SvgPicture.asset(
                      AppIcons.shop,
                      width: 20.h,
                      color: AdaptiveTheme.of(context).theme.canvasColor,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'markets'.tr,
                      style: AppTextStyles.bodyMedium(context,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ':',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '${widget.user.markets.length} ${'piece'.tr}',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ],
                ),
                UserStoresWidget(user: widget.user),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.dollar,
                      color: AdaptiveTheme.of(context).theme.canvasColor,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'benefit'.tr,
                      style: AppTextStyles.bodyMedium(context,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '${widget.user.sumOfOrders} UZS',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.calendar,
                      color: AdaptiveTheme.of(context).theme.canvasColor,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'createt'.tr,
                      style: AppTextStyles.bodyMedium(context,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      widget.user.createdAt == null
                          ? 'milloddan avval'
                          : dateTimeToFormat(widget.user.createdAt!),
                      style: AppTextStyles.bodyMedium(context, fontSize: 14.sp),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: height(context) * 0.03,
                    ),
                    SizedBox(
                      width: 4.w,
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
                      widget.user.isBlocked ? 'blocked'.tr : 'active'.tr,
                      style: AppTextStyles.bodyMedium(context,
                          color:
                              widget.user.isBlocked ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.password,
                      size: height(context) * 0.03,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      "${'password'.tr}: ",
                      style: AppTextStyles.bodyMedium(context,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      widget.user.password,
                      style: AppTextStyles.bodyMedium(context,
                          color:
                              widget.user.isBlocked ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context) * 0.01,
                ),
                widget.user.isBlocked
                    ? OrderSheetItemWidget(
                        context: context,
                        text: 'unblock'.tr,
                        color: Colors.green,
                        onTap: () {
                          widget.user.isBlocked = false;
                          context
                              .read<AdminBloc>()
                              .add(UpdateUserBEvent(widget.user));
                        })
                    : OrderSheetItemWidget(
                        context: context,
                        text: 'block'.tr,
                        color: Colors.red,
                        onTap: () {
                          widget.user.isBlocked = true;
                          context
                              .read<AdminBloc>()
                              .add(UpdateUserBEvent(widget.user));
                        }),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              textStyle: const TextStyle(color: Colors.red),
              child: Text('close'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}

// ignore: non_constant_identifier_names
OnTap OrderSheetItemWidget(
        {required VoidCallback onTap,
        required BuildContext context,
        required String text,
        required Color color}) =>
    OnTap(
      onTap: onTap,
      child: Container(
        height: height(context) * 0.04,
        width: width(context),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: Text(
            text.tr,
            style: AppTextStyles.bodyMedium(context, fontSize: 14.sp),
          ),
        ),
      ),
    );
