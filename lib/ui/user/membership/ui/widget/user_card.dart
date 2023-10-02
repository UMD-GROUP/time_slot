import 'package:time_slot/ui/user/membership/ui/widget/user_card_button.dart';
import 'package:time_slot/ui/user/membership/ui/widget/user_card_item.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: height(context) * 0.22,
        width: width(context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            color: Colors.deepPurple),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.balance,
                  color: Colors.white,
                  height: height(context) * 0.032,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "${'balance'.tr} ${context.read<UserBloc>().state.user!.card.balance} so'm",
                  style: AppTextStyles.labelLarge(context,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            UserCardItem(
                icon: AppIcons.refresh,
                text1: 'in_progress',
                text2: context
                    .read<UserBloc>()
                    .state
                    .user!
                    .card
                    .purchaseInProgress
                    .toString(),
                text3: 'uz_sum'),
            UserCardItem(
                icon: AppIcons.users,
                text1: 'referalls',
                text2: context
                    .read<UserBloc>()
                    .state
                    .user!
                    .card
                    .referrals
                    .toString(),
                text3: 'piece'),
            UserCardItem(
                icon: AppIcons.check,
                text1: 'total_amount_withdrawn',
                text2: context
                    .read<UserBloc>()
                    .state
                    .user!
                    .card
                    .allPurchased
                    .toString(),
                text3: 'uz_sum'),
            UserCardButton(onTap: () {
              if (context
                  .read<UserBloc>()
                  .state
                  .user!
                  .card
                  .cardNumber
                  .isNotEmpty) {
                showMoneyInputDialog(context);
              } else {
                AnimatedSnackBar(
                  duration: const Duration(seconds: 4),
                  snackBarStrategy: RemoveSnackBarStrategy(),
                  builder: (context) =>
                      AppErrorSnackBar(text: 'card_not_found'.tr),
                ).show(context);
              }
            })
          ],
        ),
      );
}
