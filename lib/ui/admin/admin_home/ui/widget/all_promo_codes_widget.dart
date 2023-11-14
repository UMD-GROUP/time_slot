import 'package:time_slot/ui/admin/admin_home/ui/widget/promo_code_item.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AllPromoCodesWidget extends StatelessWidget {
  AllPromoCodesWidget({this.isAdmin = false, super.key});
  bool isAdmin;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Scaffold(
          backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
          body: BlocConsumer<PromoCodeBloc, PromoCodeState>(
            listener: (context, state) {
              if (state.gettingStatus == ResponseStatus.pure) {
                context.read<PromoCodeBloc>().add(GetPromoCodesEvent());
              }
              if (state.deletingStatus == ResponseStatus.inProgress ||
                  state.creatingStatus == ResponseStatus.inProgress) {
                showLoadingDialog(context);
              }
              if (state.deletingStatus == ResponseStatus.inSuccess ||
                  state.creatingStatus == ResponseStatus.inSuccess) {
                context.read<PromoCodeBloc>().add(GetPromoCodesEvent());
                Navigator.pop(context);
                AnimatedSnackBar(
                  duration: const Duration(seconds: 4),
                  snackBarStrategy: RemoveSnackBarStrategy(),
                  builder: (context) => AppSnackBar(
                      text: 'done_successfully'.tr,
                      icon: '',
                      color: Colors.lightGreenAccent),
                ).show(context);
              }
              if (state.deletingStatus == ResponseStatus.inFail ||
                  state.creatingStatus == ResponseStatus.inFail) {
                Navigator.pop(context);
                AnimatedSnackBar(
                    duration: const Duration(seconds: 4),
                    snackBarStrategy: RemoveSnackBarStrategy(),
                    builder: (context) =>
                        AppErrorSnackBar(text: state.message)).show(context);
              }
            },
            builder: (context, state) => ListView(
              shrinkWrap: true,
              children: [
                state.promoCodes.isEmpty
                    ? Lottie.asset(AppLotties.empty)
                    : const SizedBox(),
                ...List.generate(
                    state.promoCodes.length,
                    (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          child: PromoCodeItem(
                              promoCode: state.promoCodes[index],
                              isAdmin: isAdmin),
                        ))
              ],
            ),
          ),
          floatingActionButton: isAdmin
              ? FloatingActionButton(
                  backgroundColor: Colors.deepPurple,
                  child: const Icon(Icons.add, color: Colors.white),
                  onPressed: () async {
                    showCreatePromoCodeDialog(context);
                  },
                )
              : null,
        ),
      );
}
