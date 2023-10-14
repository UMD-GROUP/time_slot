import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class PartnerDialog extends StatelessWidget {
  PartnerDialog({required this.user, super.key});
  UserModel user;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Text('partner_data'.tr),
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
                    'balance'.tr,
                    style: AppTextStyles.bodyMedium(context,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    user.card.balance.toString(),
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
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.refresh,
                    color: AdaptiveTheme.of(context).theme.canvasColor,
                    height: height(context) * 0.03,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    'progress'.tr,
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
                    user.card.purchaseInProgress.toInt().toString(),
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.users,
                    color: AdaptiveTheme.of(context).theme.canvasColor,
                    height: height(context) * 0.03,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    'referalls'.tr,
                    style: AppTextStyles.bodyMedium(context,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    '${user.referrals.length} ${'piece'.tr}',
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.download,
                    color: AdaptiveTheme.of(context).theme.canvasColor,
                    height: height(context) * 0.03,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    'total_amount_withdrawn'.tr,
                    style: AppTextStyles.bodyMedium(context,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    user.card.allPurchased.toString(),
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ],
              ),
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
                    'komissiya'.tr,
                    style: AppTextStyles.bodyMedium(context,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    user.willGetPercent == true
                        ? '${context.read<DataFromAdminBloc>().state.data!.partnerPercent.toString()}%'
                        : '0%',
                    // user.card.balance.toString(),
                    style: AppTextStyles.bodyMedium(context,
                        color: user.willGetPercent == true
                            ? Colors.green
                            : Colors.red),
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
                    user.createdAt == null
                        ? 'milloddan avval'
                        : DateTime.parse(user.createdAt.toString())
                            .toUtc()
                            .toString()
                            .split(' ')
                            .first,
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
                    style: AppTextStyles.bodyMedium(context,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    user.isBlocked ? 'blocked'.tr : 'active'.tr,
                    style: AppTextStyles.bodyMedium(context,
                        color: user.isBlocked ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              user.willGetPercent
                  ? OrderSheetItemWidget(
                      context: context,
                      text: 'block'.tr,
                      color: Colors.red,
                      onTap: () {
                        user.willGetPercent = false;
                        context.read<AdminBloc>().add(UpdateUserBEvent(user));
                      })
                  : OrderSheetItemWidget(
                      context: context,
                      text: 'unblock'.tr,
                      color: Colors.green,
                      onTap: () {
                        user.willGetPercent = true;
                        context.read<AdminBloc>().add(UpdateUserBEvent(user));
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
        width: width(context) * 0.5,
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
