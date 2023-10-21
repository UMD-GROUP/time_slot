// ignore_for_file: cascade_invocations

import 'package:time_slot/ui/user/membership/ui/widget/purchase_item_widget.dart';
import 'package:time_slot/ui/user/membership/ui/widget/purchase_shimmer_widget.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AllPurchasesWidget extends StatefulWidget {
  const AllPurchasesWidget({super.key});

  @override
  State<AllPurchasesWidget> createState() => _AllPurchasesWidgetState();
}

class _AllPurchasesWidgetState extends State<AllPurchasesWidget> {
  @override
  Widget build(BuildContext context) => BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state.purchaseUpdatingStatus == ResponseStatus.inSuccess) {
            context.read<OrderBloc>().add(GetOrderEvent());
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppSnackBar(
                  text: 'updated_successfully'.tr,
                  icon: '',
                  color: AppColors.c7FCD51),
            ).show(context);
            setState(() {});
          } else if (state.purchaseUpdatingStatus == ResponseStatus.inFail) {
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppErrorSnackBar(text: state.message),
            ).show(context);
          } else if (state.purchaseUpdatingStatus ==
              ResponseStatus.inProgress) {
            Navigator.pop(context);
            Navigator.pop(context);
            showLoadingDialog(context);
          }
        },
        child: BlocBuilder<PurchaseBloc, PurchaseState>(
          builder: (context, state) {
            if (state.status == ResponseStatus.pure) {
              context.read<PurchaseBloc>().add(GetPurchasesEvent());
            } else if (state.status == ResponseStatus.inProgress) {
              return const PurchaseShimmerWidget();
            } else if (state.status == ResponseStatus.inSuccess) {
              final List<PurchaseModel> curData = state.orders!.cast();
              curData.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

              return curData.isEmpty
                  ? Center(
                      child: SizedBox(
                          height: height(context) * 0.34,
                          child: Lottie.asset(AppLotties.empty)),
                    )
                  : Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          ...List.generate(
                              curData.length,
                              (index) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: PurchasesItemWidget(
                                        purchaseModel: curData[index],
                                        isAdmin: true),
                                  ))
                        ],
                      ),
                    );
            }
            return const Center(
              child: Text('error'),
            );
          },
        ),
      );
}
