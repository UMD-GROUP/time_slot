// ignore_for_file: cascade_invocations

import 'package:time_slot/ui/admin/admin_home/ui/widget/price_item.dart';

import '../../../../../utils/tools/file_importers.dart';

class PricesView extends StatefulWidget {
  const PricesView({super.key});

  @override
  State<PricesView> createState() => _PricesViewState();
}

class _PricesViewState extends State<PricesView> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state.updatePricesStatus == ResponseStatus.inSuccess) {
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
          } else if (state.updatePricesStatus == ResponseStatus.inFail) {
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppErrorSnackBar(text: state.message),
            ).show(context);
          } else if (state.updatePricesStatus == ResponseStatus.inProgress) {
            showLoadingDialog(context);
          }
        },
        child: SizedBox(
          height: height(context) * 0.08,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  context.read<DataFromAdminBloc>().state.data!.prices.length +
                      1,
              itemBuilder: (context, index) => index ==
                          context
                              .read<DataFromAdminBloc>()
                              .state
                              .data!
                              .prices
                              .length &&
                      index != 16
                  ? OnTap(
                      onTap: () {
                        controller.clear();
                        showPriceInputDialog(context, () {
                          if (controller.text.isNotEmpty) {
                            Navigator.pop(context);
                            final List prices = context
                                .read<DataFromAdminBloc>()
                                .state
                                .data!
                                .prices;
                            prices.add(int.parse(controller.text.trim()));
                            context
                                .read<AdminBloc>()
                                .add(UpdatePricesEvent(prices));
                          }
                        }, controller);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          children: [
                            Text((index + 1).toString(),
                                style: AppTextStyles.labelLarge(context)),
                            Container(
                              height: height(context) * 0.043,
                              width: width(context) * 0.2,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(4.r)),
                              child: Icon(Icons.add,
                                  color: AdaptiveTheme.of(context)
                                      .theme
                                      .hintColor),
                            ),
                          ],
                        ),
                      ),
                    )
                  : index == 15
                      ? null
                      : PriceItem(index: index)),
        ),
      );
}
