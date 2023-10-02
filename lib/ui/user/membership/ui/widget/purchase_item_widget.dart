import 'package:time_slot/utils/tools/file_importers.dart';

class PurchasesItemWidget extends StatelessWidget {
  const PurchasesItemWidget({super.key, required this.purchaseModel});
  final PurchaseModel purchaseModel;

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      height: height(context) * 0.11,
      width: width(context),
      decoration: BoxDecoration(
         color: AdaptiveTheme.of(context).theme.disabledColor,
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(color: Colors.deepPurple),
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 4.w,),
          Container(
              height: height(context)*0.1,
              width: width(context)*0.25,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: SvgPicture.asset(AppIcons.refresh, color: Colors.white,height: height(context)*0.05,))),
          SizedBox(width: 10.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PurchaseTextWidget(icon: AppIcons.check, text1: 'payment',text2: purchaseModel.purchaseId.toString(),),
              PurchaseTextWidget(icon: AppIcons.dollar, text1: 'amount',text2: purchaseModel.amount.toString(),),
              Row(
                     children: [
                     SvgPicture.asset( AppIcons.alert, color: AdaptiveTheme.of(context).theme.canvasColor, height: height(context)*0.025,),
                     SizedBox(width: 5.w,),
                     Text('Status:'.tr, style: AppTextStyles.bodyMedium(context),),
                     SizedBox(width: 3.w,),
                     Text(purchaseModel.status == PurchaseStatus.finished ? 'done'.tr: purchaseModel.status == PurchaseStatus.inProgress ? 'progress'.tr:   purchaseModel.status == PurchaseStatus.created ? 'created'.tr:  'cancelled'.tr, style: AppTextStyles.bodyMedium(context,
                       color:purchaseModel.status == PurchaseStatus.finished ? Colors.green: purchaseModel.status == PurchaseStatus.inProgress ? Colors.amber:   purchaseModel.status == PurchaseStatus.created ? Colors.deepPurple : Colors.red
                     ),),
                   ],
                 ),

            ],
          ),
          const Spacer(),
        ],
      ),
    );

  // ignore: non_constant_identifier_names
}
