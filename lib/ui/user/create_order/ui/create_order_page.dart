// ignore_for_file: use_named_constants, cascade_invocations
import 'package:flutter/cupertino.dart';
import 'package:time_slot/ui/user/create_order/ui/widgets/order_confirm_bottom_sheet.dart';
import 'package:time_slot/ui/user/create_order/ui/widgets/select_dates_section.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  List<DateTime> dates = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('create_order'.tr),
        ),
        body: SafeArea(
            child: Container(
          height: height(context),
          width: width(context),
          padding: EdgeInsets.all(20.h),
          child: BlocConsumer<CreateOrderBloc, CreateOrderState>(
            listener: (context, state) {
              if (state.addingStatus == ResponseStatus.inSuccess) {
                context.read<OrderBloc>().add(GetOrderEvent());
                Navigator.pop(context);
                AnimatedSnackBar(
                  snackBarStrategy: RemoveSnackBarStrategy(),
                  builder: (context) => AppSnackBar(
                      text: 'ordered_successfully'.tr,
                      icon: '',
                      color: AppColors.c7FCD51),
                ).show(context);
                Navigator.pop(context);
              } else if (state.addingStatus == ResponseStatus.inFail) {
                Navigator.pop(context);
                AnimatedSnackBar(
                  snackBarStrategy: RemoveSnackBarStrategy(),
                  builder: (context) => AppErrorSnackBar(text: state.message),
                ).show(context);
              } else if (state.addingStatus == ResponseStatus.inProgress) {
                showLoadingDialog(context);
              }
            },
            builder: (context, orderState) => BlocProvider(
              create: (context) => StepControllerBloc(),
              child: BlocBuilder<StepControllerBloc, StepControllerState>(
                builder: (context, state) => SingleChildScrollView(
                  child: Column(
                    children: [
                      Stepper(
                          margin: const EdgeInsets.only(left: 60),
                          onStepCancel: () {
                            context
                                .read<StepControllerBloc>()
                                .add(ToPreviousStepEvent());
                          },
                          currentStep: state.currentStep,
                          onStepContinue: () {
                            context
                                .read<StepControllerBloc>()
                                .add(ToNextStepEvent());
                          },
                          onStepTapped: (value) {
                            context
                                .read<StepControllerBloc>()
                                .add(ToStepEvent(value));
                          },
                          connectorColor:
                              MaterialStateProperty.all(Colors.deepPurple),
                          steps: [
                            Step(
                              title: Text(
                                'choose_market'.tr,
                                // style: AppTextStyles.labelLarge(context),
                              ),
                              content: const MarketOption(),
                            ),
                            Step(
                              title: Text(
                                'choose_dates'.tr,
                                // style: AppTextStyles.labelLarge(context),
                              ),
                              content: const SelectDatesSection(),
                            ),
                            Step(
                                title: Text('products'.tr),
                                content: const AddProductSection()),
                            Step(
                                title: Text('choose_photo'.tr),
                                content: const ImageSection())
                          ]),
                      SizedBox(height: height(context) * 0.05),
                      Visibility(
                        visible: state.currentStep == 3,
                        child: GlobalButton(
                            isLoading: orderState.addingStatus ==
                                ResponseStatus.inProgress,
                            onTap: () {
                              final OrderModel order = orderState.order;
                              order.sum = context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .prices[order.dates.length - 1];

                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => InfoBottomSheet(
                                  order: order,
                                ),
                              );
                            },
                            color: Colors.deepPurple,
                            title: 'order'.tr,
                            textColor: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )),
      );
}
