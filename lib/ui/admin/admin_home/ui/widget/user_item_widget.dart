import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class UsersItemWidget extends StatelessWidget {
  const UsersItemWidget(
      {super.key, required this.userModel, required this.isPartner});
  final bool isPartner;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) => ZoomTapAnimation(
        onTap: () {
          context.read<StoresBloc>().add(GetStoresEvent(userModel.uid));
          showUserPopUp(context, userModel);
        },
        onLongTap: () {
          if (userModel.markets.length != 5) {
            showCupertinoDialog(
              context: context,
              builder: (context) => AddStoreDialog(user: userModel),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.h),
          height: height(context) * 0.11,
          width: width(context),
          decoration: BoxDecoration(
            color: AdaptiveTheme.of(context).theme.disabledColor,
            borderRadius: BorderRadius.circular(10.h),
            border: Border.all(color: Colors.deepPurple),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 4.w,
              ),
              Container(
                  height: height(context) * 0.1,
                  width: width(context) * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: isPartner
                          ? SvgPicture.asset(
                              AppIcons.users,
                              color:
                                  AdaptiveTheme.of(context).theme.canvasColor,
                            )
                          : const Icon(
                              Icons.person,
                              color: Colors.white,
                            ))),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                width: width(context) * 0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowText(
                      icon: AppIcons.check,
                      text1: 'Email:',
                      text2: userModel.email.toString().length > 15
                          ? userModel.email.substring(0, 15)
                          : userModel.email,
                    ),
                    // RowText(
                    //   icon: AppIcons.dollar,
                    //   text1: 'benefit',
                    //   text2: '${userModel.sumOfOrders}  UZS',
                    // ),
                    RowText(
                      icon: AppIcons.check,
                      text1: 'orders'.tr,
                      text2: '${userModel.orders.length} ${'piece'.tr}',
                    ),
                    RowText(
                      icon: AppIcons.check,
                      text1: 'referrals'.tr,
                      text2: '${userModel.referrals.length} ${'piece'.tr}',
                    ),
                    RowText(
                      textColor: userModel.isBlocked
                          ? Colors.red
                          : Colors.lightGreenAccent,
                      icon: AppIcons.check,
                      text1: 'status'.tr,
                      text2: userModel.isBlocked ? 'blocked'.tr : 'active'.tr,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

// ignore: non_constant_identifier_names
}
