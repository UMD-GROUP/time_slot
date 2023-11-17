import '../../../../../utils/tools/file_importers.dart';

class StoreItem extends StatelessWidget {
  StoreItem(
      {this.isAdmin = false,
      required this.index,
      this.user,
      required this.store,
      super.key});
  StoreModel store;
  int index;
  bool isAdmin;
  UserModel? user;

  @override
  Widget build(BuildContext context) => Container(
        width: width(context),
        margin: EdgeInsets.symmetric(vertical: isAdmin ? 4.h : 2.h),
        child: Row(
          children: [
            SizedBox(
              width: isAdmin ? width(context) * 0.06 : width(context) * 0.25,
              child: Text(
                "${index + 1} - ${isAdmin ? '' : '${'store'.tr}: '}",
                style: AppTextStyles.labelLarge(context,
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: width(context) * 0.33,
              child: Text(
                store.name.length > 14
                    ? '${store.name.substring(0, 12)}...'
                    : store.name,
                textAlign: TextAlign.start,
                style: AppTextStyles.labelLarge(context,
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            if (isAdmin)
              Row(
                children: [
                  OnTap(
                      onTap: () {
                        final TextEditingController id = TextEditingController()
                          ..text = store.id;
                        final TextEditingController market =
                            TextEditingController()..text = store.name;
                        showUpdateStoreDialog(context, id, market, store);
                      },
                      child: const Icon(Icons.edit)),
                  SizedBox(width: 26.h),
                  OnTap(
                      onTap: () {
                        showConfirmCancelDialog(context, () {
                          context
                              .read<StoresBloc>()
                              .add(DeleteStoreEvent(user!.markets[index]));
                          user!.markets.removeAt(index);
                          context
                              .read<AdminBloc>()
                              .add(UpdateUserBEvent(user!));
                        });
                      },
                      child: const Icon(Icons.delete, color: Colors.red)),
                ],
              )
          ],
        ),
      );
}
