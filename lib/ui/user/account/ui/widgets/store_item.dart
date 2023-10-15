import '../../../../../utils/tools/file_importers.dart';

class StoreItem extends StatelessWidget {
  StoreItem(
      {this.isAdmin = false,
      required this.index,
      this.user,
      required this.title,
      super.key});
  String title;
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
                title.length > 14 ? '${title.substring(0, 12)}...' : title,
                textAlign: TextAlign.start,
                style: AppTextStyles.labelLarge(context,
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            if (isAdmin)
              Row(
                children: [
                  OnTap(
                      onTap: () {
                        final TextEditingController controller =
                            TextEditingController()..text = title;
                        showTextInputDialog(context, onConfirmTapped: () {
                          user!.markets[index] = controller.text;
                          context
                              .read<AdminBloc>()
                              .add(UpdateUserBEvent(user!));
                        },
                            controller: controller,
                            title: 'market_name'.tr,
                            hintText: ' ');
                      },
                      child: const Icon(Icons.edit)),
                  SizedBox(width: 26.h),
                  OnTap(
                      onTap: () {
                        showConfirmCancelDialog(context, () {
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
