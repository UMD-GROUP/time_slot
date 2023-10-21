import 'package:time_slot/utils/tools/file_importers.dart';

class BannerItemAdmin extends StatelessWidget {
  BannerItemAdmin({required this.image, super.key});

  String image;

  @override
  Widget build(BuildContext context) => BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state.deleteBannerStatus == ResponseStatus.inSuccess) {
            context.read<DataFromAdminBloc>().add(GetBannersEvent());
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppSnackBar(
                  text: 'added_successfully'.tr,
                  icon: '',
                  color: AppColors.c7FCD51),
            ).show(context);
          } else if (state.deleteBannerStatus == ResponseStatus.inFail) {
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppErrorSnackBar(text: state.message),
            ).show(context);
          } else if (state.deleteBannerStatus == ResponseStatus.inProgress) {
            showLoadingDialog(context);
          }
        },
        child: OnTap(
          onTap: () {
            showDeleteDialog(context, image);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Container(
              height: height(context) * 0.06,
              width: width(context) * 0.25,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image)),
                  borderRadius: BorderRadius.circular(4.r)),
            ),
          ),
        ),
      );
}
