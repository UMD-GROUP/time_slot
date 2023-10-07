import 'package:time_slot/ui/admin/admin_home/ui/widget/user_item_widget.dart';
import 'package:time_slot/ui/user/membership/ui/widget/purchase_shimmer_widget.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AllUsersWidget extends StatelessWidget {
  const AllUsersWidget({super.key, required this.isPartner});
  final bool isPartner;

  @override
  Widget build(BuildContext context) => BlocBuilder<AllUserBloc, AllUserState>(
    builder: (context, state) {
      if(state.status == ResponseStatus.pure){
        context.read<AllUserBloc>().add(GetAllUserEvent());
      }
      else if(state.status == ResponseStatus.inProgress){
        return const PurchaseShimmerWidget();
      }
      else if (state.status == ResponseStatus.inSuccess){
        final List<UserModel> curData = state.users!.cast();
        final List<UserModel> data = curData.where((element) => element.referrals.isNotEmpty).toList();
        return curData.isEmpty ?
        Center(child: SizedBox( height: height(context)*0.34,child: Lottie.asset(AppLotties.empty)),)
            :  Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ...List.generate(
                  isPartner ? data.length: curData.length,
                      (index) => Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8.w),
                    child: UsersItemWidget(userModel: isPartner ? data[index]  : curData[index]),
                  ))
            ],
          ),
        );
      }
      return const Center(child: Text('error'),);
    },
  );
}
