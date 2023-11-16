import 'package:time_slot/ui/admin/control/ui/sub_pages/widgets/users_view.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
          title: Text('users'.tr, style: AppTextStyles.labelLarge(context)),
        ),
        body: BlocListener<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state.userUpdatingStatus == ResponseStatus.inSuccess) {
              context.read<DataFromAdminBloc>().add(GetBannersEvent());
              Navigator.pop(context);
              AnimatedSnackBar(
                snackBarStrategy: RemoveSnackBarStrategy(),
                builder: (context) => AppSnackBar(
                    text: 'updated_successfully'.tr,
                    icon: '',
                    color: AppColors.c7FCD51),
              ).show(context);
            } else if (state.userUpdatingStatus == ResponseStatus.inFail) {
              Navigator.pop(context);
              AnimatedSnackBar(
                snackBarStrategy: RemoveSnackBarStrategy(),
                builder: (context) => AppErrorSnackBar(text: state.message),
              ).show(context);
            } else if (state.userUpdatingStatus == ResponseStatus.inProgress) {
              Navigator.pop(context);
              showLoadingDialog(context);
            }
          },
          child: BlocBuilder<AllUserBloc, AllUserState>(
            builder: (context, state) {
              if (state.status == ResponseStatus.pure) {
                context.read<AllUserBloc>().add(GetAllUserEvent());
              } else if (state.status == ResponseStatus.inSuccess) {
                final List<UserModel> curData = state.users!.cast();
                final List<UserModel> data = curData
                    .where((element) => element.referrals.isNotEmpty)
                    .toList();
                curData
                    .sort((a, b) => b.sumOfOrders!.compareTo(a.sumOfOrders!));
                return SizedBox(
                  height: height(context),
                  width: width(context),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: AdaptiveTheme.of(context).theme.hintColor,
                          indicatorColor: Colors.deepPurple,
                          tabs: [
                            Tab(text: 'good_users'.tr),
                            Tab(text: 'active'.tr),
                            Tab(text: 'blocked'.tr),
                          ],
                        ),
                        SizedBox(height: height(context) * 0.02),
                        Expanded(
                          child: TabBarView(children: [
                            UsersView(curData
                                .where((element) => element.sumOfOrders != 0)
                                .toList()),
                            UsersView(splitUsers(curData, false)),
                            UsersView(splitUsers(curData, true))
                          ]),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: Text('error'),
              );
            },
          ),
        ),
      );
}
