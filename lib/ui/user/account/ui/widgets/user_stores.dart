import 'package:flutter/cupertino.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class UserStores extends StatefulWidget {
  const UserStores({super.key});

  @override
  State<UserStores> createState() => _UserStoresState();
}

class _UserStoresState extends State<UserStores> {
  @override
  Widget build(BuildContext context) =>
      BlocListener<UserAccountBloc, UserAccountState>(
        listener: (context, state) {
          if (state.addStoreStatus == ResponseStatus.inProgress) {
            showLoadingDialog(context);
          }
          if (state.addStoreStatus == ResponseStatus.inFail) {
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppErrorSnackBar(
                text: state.message,
              ),
            ).show(context);
          } else if (state.addStoreStatus == ResponseStatus.inSuccess) {
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppSnackBar(
                color: AppColors.c7FCD51,
                text: 'added_successfully'.tr,
                icon: '',
              ),
            ).show(context);
            setState(() {});
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => Container(
            width: width(context),
            padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: state.user!.markets.isEmpty ? 10 : 0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Visibility(
                  visible: state.user!.markets.isEmpty,
                  child: Text('no_markets_yet'.tr,
                      style: AppTextStyles.labelLarge(context,
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: height(context) * 0.02),
                ...List.generate(
                    state.user!.markets.length,
                    (index) => StoreItem(
                        index: index, title: state.user?.markets[index])),
                if (state.user?.markets.length != 5)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) =>
                              AddStoreDialog(user: state.user!),
                        );
                      },
                      child: Text(
                        'add'.tr,
                      )),
              ],
            ),
          ),
        ),
      );
}
