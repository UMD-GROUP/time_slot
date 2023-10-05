// ignore_for_file: use_build_context_synchronously
import 'package:time_slot/ui/admin/admin_home/ui/widget/banner_item_admin.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AdminBannerWidget extends StatefulWidget {
  const AdminBannerWidget({super.key});

  @override
  State<AdminBannerWidget> createState() => _AdminBannerWidgetState();
}

class _AdminBannerWidgetState extends State<AdminBannerWidget> {
  @override
  Widget build(BuildContext context) => BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state.deleteBannerStatus == ResponseStatus.inSuccess ||
              state.updatePricesStatus == ResponseStatus.inSuccess ||
              state.updateOthersStatus == ResponseStatus.inSuccess) {
            setState(() {});
          }
          if (state.addBannerStatus == ResponseStatus.inSuccess) {
            context.read<DataFromAdminBloc>().add(GetBannersEvent());
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppSnackBar(
                  text: 'added_successfully'.tr,
                  icon: '',
                  color: AppColors.c7FCD51),
            ).show(context);
            setState(() {});
          } else if (state.addBannerStatus == ResponseStatus.inFail) {
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppErrorSnackBar(text: state.message),
            ).show(context);
          } else if (state.addBannerStatus == ResponseStatus.inProgress) {
            showLoadingDialog(context);
          }
        },
        child: SizedBox(
          height: height(context) * 0.06,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  context.read<DataFromAdminBloc>().state.data!.banners.length +
                      1,
              itemBuilder: (context, index) => index ==
                      context
                          .read<DataFromAdminBloc>()
                          .state
                          .data!
                          .banners
                          .length
                  ? OnTap(
                      onTap: () async {
                        final XFile? pickedImage = await showPicker(context);
                        context.read<AdminBloc>().add(AddBannerEvent(
                            pickedImage!.path,
                            context.read<DataFromAdminBloc>().state.data!));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Container(
                          height: height(context) * 0.06,
                          width: width(context) * 0.25,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(4.r)),
                          child: Icon(Icons.add,
                              color: AdaptiveTheme.of(context).theme.hintColor),
                        ),
                      ),
                    )
                  : BannerItemAdmin(
                      image: context
                          .read<DataFromAdminBloc>()
                          .state
                          .data!
                          .banners[index])),
        ),
      );
}
