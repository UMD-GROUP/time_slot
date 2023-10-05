import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class UserDialog extends StatelessWidget {
  UserDialog({required this.user, super.key});
  UserModel user;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
    title: Text('user_data'.tr),

    content: SizedBox(
      width: width(context)*0.7,
      child: Column(
        children: [
          Container(
            height: height(context)*0.15,
            width: width(context),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10.r)
            ),child: Center(
            child: SvgPicture.asset(AppIcons.refresh, height: height(context)*0.05,),
          ),

          ),
          SizedBox(height: height(context)*0.01,),
          Row(
            children: [
              Icon(Icons.person_2_outlined, size: height(context)*0.03,),
              SizedBox(width: 4.w,),
              Text('User:', style: AppTextStyles.bodyMedium(context),),
              SizedBox(width: 10.w,),
              Text(user.token,style: AppTextStyles.bodyMedium(context),),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.users),
              SizedBox(width: 4.w,),
              Text('Partner:', style: AppTextStyles.bodyMedium(context),),
              SizedBox(width: 10.w,),
              Text(user.token,style: AppTextStyles.bodyMedium(context),),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.check),
              SizedBox(width: 4.w,),
              Text('Orders:', style: AppTextStyles.bodyMedium(context),),
              SizedBox(width: 10.w,),
              Text(user.token,style: AppTextStyles.bodyMedium(context),),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.dollar),
              SizedBox(width: 4.w,),
              Text('Foyda:', style: AppTextStyles.bodyMedium(context),),
              SizedBox(width: 10.w,),
              Text(user.token,style: AppTextStyles.bodyMedium(context),),
            ],
          ),

          Row(
            children: [
              SvgPicture.asset(AppIcons.calendar),
              SizedBox(width: 4.w,),
              Text('Faoliyat:', style: AppTextStyles.bodyMedium(context),),
              SizedBox(width: 10.w,),
              Text(user.referallId,style: AppTextStyles.bodyMedium(context),),
            ],
          ),
          Row(
            children: [
              Icon(Icons.info_outline, size: height(context)*0.03,),
              SizedBox(width: 4.w,),
              Text('status:', style: AppTextStyles.bodyMedium(context),),
              SizedBox(width: 10.w,),
              Text(user.token,style: AppTextStyles.bodyMedium(context),),
            ],
          ),
         SizedBox(height: height(context)*0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OrderSheetItemWidget(
                  context: context, text: 'block', color: Colors.red, onTap: (){}),
              OrderSheetItemWidget(
                  context: context, text: 'UnBlock', color: Colors.green, onTap: (){}),
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
        child: Text('ok'.tr),
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
        width: width(context) * 0.18,
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
