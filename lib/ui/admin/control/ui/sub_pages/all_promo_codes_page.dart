// ignore_for_file: cascade_invocations

import 'package:time_slot/ui/admin/control/ui/sub_pages/widgets/promo_codes_view.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AllPromoCodesPage extends StatelessWidget {
  const AllPromoCodesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<PromoCodeBloc>().add(GetPromoCodesEvent());
                },
                icon: const Icon(Icons.refresh))
          ],
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          title: Text('promo_codes'.tr,
              style: AppTextStyles.labelLarge(context,
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
        ),
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        body: BlocConsumer<PromoCodeBloc, PromoCodeState>(
          listener: (context, state) {
            if (state.gettingStatus == ResponseStatus.pure) {
              context.read<PromoCodeBloc>().add(GetPromoCodesEvent());
            }
            if (state.deletingStatus == ResponseStatus.inProgress ||
                state.creatingStatus == ResponseStatus.inProgress ||
                state.updatingStatus == ResponseStatus.inProgress) {
              showLoadingDialog(context);
            }
            if (state.deletingStatus == ResponseStatus.inSuccess ||
                state.creatingStatus == ResponseStatus.inSuccess ||
                state.updatingStatus == ResponseStatus.inSuccess) {
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
                state.creatingStatus == ResponseStatus.inFail ||
                state.updatingStatus == ResponseStatus.inFail) {
              Navigator.pop(context);
              AnimatedSnackBar(
                  duration: const Duration(seconds: 4),
                  snackBarStrategy: RemoveSnackBarStrategy(),
                  builder: (context) =>
                      AppErrorSnackBar(text: state.message)).show(context);
            }
          },
          builder: (context, state) => DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  labelColor: AdaptiveTheme.of(context).theme.hintColor,
                  indicatorColor: Colors.deepPurple,
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: 'active'.tr),
                    Tab(text: 'inactive'.tr),
                    Tab(text: 'restricted'.tr),
                  ],
                ),
                SizedBox(height: height(context) * 0.02),
                BlocBuilder<PromoCodeBloc, PromoCodeState>(
                  builder: (context, state) {
                    if (state.gettingStatus == ResponseStatus.pure) {
                      context.read<AllUserBloc>().add(GetAllUserEvent());
                    } else if (state.gettingStatus ==
                        ResponseStatus.inSuccess) {
                      final List<PromoCodeModel> curData =
                          state.promoCodes.cast();
                      curData.sort((a, b) =>
                          b.usedOrders.length!.compareTo(a.usedOrders.length));
                      return Expanded(
                        child: TabBarView(children: [
                          PromoCodesView(curData
                              .where((element) => element.isVisible)
                              .toList()),
                          PromoCodesView(curData
                              .where((element) => !element.isVisible)
                              .toList()),
                          PromoCodesView(curData
                              .where((element) => element.maxUsingLimit > 0)
                              .toList()),

                          //
                          // PromoCodesView(curData
                          //     .where((element) => element.)
                          //     .toList()),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () async {
            showCreatePromoCodeDialog(context);
          },
        ),
      );
}
