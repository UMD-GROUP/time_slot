import 'package:time_slot/utils/tools/file_importers.dart';

class UsersItemWidget extends StatelessWidget {
  const UsersItemWidget({super.key, required this.userModel});
  final UserModel userModel;

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
            PurchaseTextWidget(icon: AppIcons.check, text1: 'emails:',text2: userModel.email.toString(),),
            PurchaseTextWidget(icon: AppIcons.dollar, text1: 'balance',text2: userModel.card.balance.toString(),),
            PurchaseTextWidget(icon: AppIcons.check, text1: 'referallId:',text2: userModel.referallId.toString(),),

          ],
        ),
        const Spacer(),
      ],
    ),
  );

// ignore: non_constant_identifier_names
}
