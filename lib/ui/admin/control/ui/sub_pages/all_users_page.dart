// ignore_for_file: cascade_invocations

import 'package:time_slot/ui/admin/control/ui/sub_pages/widgets/users_view.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AllUserBloc>().add(GetAllUserEvent());
                },
                icon: const Icon(Icons.refresh, color: Colors.white))
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          title: Text('users'.tr,
              style: AppTextStyles.labelLarge(context,
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
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
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                TabBar(
                  labelColor: AdaptiveTheme.of(context).theme.hintColor,
                  indicatorColor: Colors.deepPurple,
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: 'good_users'.tr),
                    Tab(text: 'active'.tr),
                    Tab(text: 'blocked'.tr),
                    Tab(text: 'admins'.tr),
                  ],
                ),
                SizedBox(height: height(context) * 0.02),
                BlocBuilder<AllUserBloc, AllUserState>(
                  builder: (context, state) {
                    if (state.status == ResponseStatus.pure) {
                      context.read<AllUserBloc>().add(GetAllUserEvent());
                    } else if (state.status == ResponseStatus.inSuccess) {
                      final List<UserModel> curData = state.users!.cast();
                      curData.sort(
                          (a, b) => b.sumOfOrders.compareTo(a.sumOfOrders));
                      curData
                          .sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                      return Expanded(
                        child: TabBarView(children: [
                          UsersView(curData
                              .where((element) => element.sumOfOrders != 0)
                              .toList()),
                          UsersView(splitUsers(curData, false)),
                          UsersView(splitUsers(curData, true)),
                          UsersView(curData
                              .where((element) => element.isAdmin)
                              .toList()),
                        ]),
                      );
                    }
                    return const Center(
                      child: Text('error'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
