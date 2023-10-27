import 'package:time_slot/utils/tools/file_importers.dart';

class UserStoresWidget extends StatelessWidget {
  UserStoresWidget({super.key, required this.user});

  UserModel user;

  @override
  Widget build(BuildContext context) => BlocConsumer<StoresBloc, StoresState>(
        listener: (context, state) {
          if (state.updatingStatus == ResponseStatus.inProgress) {
            showLoadingDialog(context);
          } else if (state.updatingStatus == ResponseStatus.inSuccess) {
            context.read<AllUserBloc>().add(GetAllUserEvent());
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppSnackBar(
                color: AppColors.c7FCD51,
                text: 'added_successfully'.tr,
                icon: '',
              ),
            ).show(context);
            Navigator.pop(context);
          } else if (state.updatingStatus == ResponseStatus.inFail) {
            context.read<AllUserBloc>().add(GetAllUserEvent());
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              duration: const Duration(seconds: 6),
              builder: (context) => AppErrorSnackBar(text: state.message),
            ).show(context);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state.gettingStatus == ResponseStatus.inSuccess) {
            print(state.stores.length);
            return Column(
              children: [
                ...List.generate(
                    state.stores.length,
                    (index) => Padding(
                          padding: EdgeInsets.only(left: 24.h),
                          child: StoreItem(
                              user: user,
                              index: index,
                              store: state.stores[index],
                              isAdmin: true),
                        )),
              ],
            );
          }
          return CustomCircularProgressIndicator(
              color: AdaptiveTheme.of(context).theme.hintColor);
        },
      );
}
