import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class UserDialog extends StatelessWidget {
  UserDialog({required this.user, super.key});
  UserModel user;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
                child: Text(
              'close',
              style: AppTextStyles.labelLarge(context, color: Colors.red),
            ))
          ],
          title: Text('user_data'.tr),
          content: SizedBox(
              width: width(context) * 0.7,
              child: Column(children: [
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
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      user.token,
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.users),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'Partner:',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      user.referallId,
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.check),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'orders'.tr,
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    Text(
                      ':',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      user.orders.length.toString(),
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.calendar),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'createt'.tr,
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'mock_data',
                      style: AppTextStyles.bodyMedium(context),
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
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'mock_data',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context) * 0.01,
                ),
                SizedBox(
                  height: height(context) * 0.01,
                ),
                user.isBlocked
                    ? OrderSheetItemWidget(
                        context: context,
                        text: 'UnBlock',
                        color: Colors.green,
                        onTap: () {
                          user.isBlocked = false;
                          context.read<AdminBloc>().add(UpdateUserBEvent(user));
                        })
                    : OrderSheetItemWidget(
                        context: context,
                        text: 'block',
                        color: Colors.red,
                        onTap: () {
                          user.isBlocked = true;
                          context.read<AdminBloc>().add(UpdateUserBEvent(user));
                        })
              ])));
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
