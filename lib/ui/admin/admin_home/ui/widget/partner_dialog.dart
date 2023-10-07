import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class PartnerDialog extends StatelessWidget {
  PartnerDialog({required this.user, super.key});
  UserModel user;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
    title: Text('partner_data'.tr),

    content: SizedBox(
      width: width(context)*0.7,
      child: Column(
        children: [
          SizedBox(height: height(context)*0.01,),
          Row(
            children: [
              SvgPicture.asset(AppIcons.balance, height: height(context)*0.03,),
              SizedBox(width: 4.w,),
              Text('balance'.tr, style: AppTextStyles.bodyMedium(context, fontWeight: FontWeight.bold),),
              SizedBox(width: 5.w,),
              Text(user.card.balance.toString(),style: AppTextStyles.bodyMedium(context),),
              SizedBox(width: 5.w,),
              Text('uz_sum'.tr, style: AppTextStyles.bodyMedium(context),),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.refresh,height: height(context)*0.03,),
              SizedBox(width: 4.w,),
              Text('progress'.tr, style: AppTextStyles.bodyMedium(context, fontWeight: FontWeight.bold),),
              Text(':', style: AppTextStyles.bodyMedium(context),),
              SizedBox(width: 10.w,),
              Text(user.card.purchaseInProgress.toString(),style: AppTextStyles.bodyMedium(context),),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.users,height: height(context)*0.03,),
              SizedBox(width: 4.w,),
              Text('referalls'.tr, style: AppTextStyles.bodyMedium(context, fontWeight: FontWeight.bold),),
              SizedBox(width: 10.w,),
              Text(user.referrals.length.toString(),style: AppTextStyles.bodyMedium(context),),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.download,height: height(context)*0.03,),
              SizedBox(width: 4.w,),
              Text('total_amount_withdrawn'.tr, style: AppTextStyles.bodyMedium(context, fontWeight: FontWeight.bold),),
              SizedBox(width: 10.w,),
              Text(user.card.allPurchased.toString(),style: AppTextStyles.bodyMedium(context),),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.dollar),
              SizedBox(width: 4.w,),
              Text('komissiya'.tr, style: AppTextStyles.bodyMedium(context, fontWeight: FontWeight.bold),),
              SizedBox(width: 5.w,),
              Text(user.card.balance.toString(),style: AppTextStyles.bodyMedium(context),),
              SizedBox(width: 5.w,),
              Text('uz_sum'.tr, style: AppTextStyles.bodyMedium(context),),
            ],
          ),

          Row(
            children: [
              SvgPicture.asset(AppIcons.calendar),
              SizedBox(width: 4.w,),
              Text('createt'.tr, style: AppTextStyles.bodyMedium(context, fontWeight: FontWeight.bold),),
              SizedBox(width: 10.w,),
              Text('mock_data',style: AppTextStyles.bodyMedium(context),),
            ],
          ),
          Row(
            children: [
              Icon(Icons.info_outline, size: height(context)*0.03,),
              SizedBox(width: 4.w,),
              Text('status'.tr, style: AppTextStyles.bodyMedium(context, fontWeight: FontWeight.bold),),
              SizedBox(width: 10.w,),
              Text('mock_data',style: AppTextStyles.bodyMedium(context),),
            ],
          ),
          SizedBox(height: height(context)*0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OrderSheetItemWidget(
                  context: context, text: 'block', color: Colors.red, onTap: (){}),
            ],
          )
        ],
      ),
    ),
    actions: <Widget>[
      // CupertinoDialogAction(
      //   child: Text('cancel'.tr),
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      // ),
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
