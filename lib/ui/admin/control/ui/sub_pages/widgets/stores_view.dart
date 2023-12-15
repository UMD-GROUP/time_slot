import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class StoresView extends StatelessWidget {
  StoresView(this.stores, {super.key});
  List<StoreModel> stores;

  @override
  Widget build(BuildContext context) => stores.isEmpty
      ? Center(
          child: SizedBox(
              height: height(context) * 0.35,
              child: Lottie.asset(AppLotties.empty)),
        )
      : BlocListener<StoresBloc, StoresState>(
          listener: (context, state) {
            if (state.updatingStatus == ResponseStatus.inSuccess) {
              context.read<StoresBloc>().add(GetAllStoresEvent());
              Navigator.pop(context);
              AnimatedSnackBar(
                snackBarStrategy: RemoveSnackBarStrategy(),
                builder: (context) => AppSnackBar(
                    text: 'updated_successfully'.tr,
                    icon: '',
                    color: AppColors.c7FCD51),
              ).show(context);
            } else if (state.updatingStatus == ResponseStatus.inFail) {
              Navigator.pop(context);
              AnimatedSnackBar(
                snackBarStrategy: RemoveSnackBarStrategy(),
                builder: (context) => AppErrorSnackBar(text: state.message),
              ).show(context);
            } else if (state.updatingStatus == ResponseStatus.inProgress) {
              Navigator.pop(context);
              showLoadingDialog(context);
            }
          },
          child: ListView.builder(
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final StoreModel store = stores[index];

                return ZoomTapAnimation(
                  onTap: () {
                    final TextEditingController id = TextEditingController()
                      ..text = store.id;
                    final TextEditingController market = TextEditingController()
                      ..text = store.name;
                    showUpdateStoreDialog(context, id, market, store);
                  },
                  onLongTap: () {
                    showConfirmCancelDialog(context, () {
                      context
                          .read<StoresBloc>()
                          .add(DeleteStoreEvent(store.storeDocId));
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10),
                    padding: EdgeInsets.all(4.h),
                    width: width(context),
                    decoration: BoxDecoration(
                      color: AdaptiveTheme.of(context).theme.disabledColor,
                      borderRadius: BorderRadius.circular(10.h),
                      border: Border.all(color: Colors.deepPurple),
                    ),
                    child: Row(
                      children: [
                        Container(
                            height: height(context) * 0.1,
                            width: width(context) * 0.24,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                                child: Icon(
                              Icons.store,
                              color: Colors.white,
                            ))),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowText(
                              icon: AppIcons.check,
                              iconData: Icons.account_tree_sharp,
                              text1: '${'ID'.tr} : ',
                              text2: '${store.id} ',
                            ),
                            RowText(
                              iconData: Icons.store,
                              icon: AppIcons.shop,
                              text1: '${'store'.tr}:',
                              text2: store.name,
                            ),
                            RowText(
                              icon: AppIcons.dollar,
                              iconData: Icons.person,
                              text1: '${'owner'.tr}:',
                              text2:
                                  makePhoneNumberFromEmail(store.owner.email),
                            ),
                            RowText(
                              iconData: Icons.access_time,
                              icon: AppIcons.check,
                              text1: 'created'.tr,
                              text2: dateTimeToFormat(store.createdAt),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
}
