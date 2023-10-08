import '../../../../../utils/tools/file_importers.dart';

class UserCardButton extends StatelessWidget {
  const UserCardButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) =>
      BlocListener<PurchaseBloc, PurchaseState>(
        listener: (context, state) {
          if (state.addingStatus == ResponseStatus.inProgress) {
            showLoadingDialog(context);
          } else if (state.addingStatus == ResponseStatus.inSuccess) {
            Navigator.pop(context);

            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppSnackBar(
                  text: 'added_successfully'.tr,
                  icon: '',
                  color: AppColors.c7FCD51),
            ).show(context);
          } else if (state.addingStatus == ResponseStatus.inFail) {
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppErrorSnackBar(text: state.message),
            ).show(context);
          }
        },
        child: OnTap(
          onTap: onTap,
          child: Container(
            height: height(context) * 0.04,
            width: height(context) * 0.18,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(6.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.download,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'purchase'.tr,
                  style: AppTextStyles.bodyMedium(context, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      );
}
