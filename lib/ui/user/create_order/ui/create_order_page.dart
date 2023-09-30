// ignore_for_file: use_named_constants, cascade_invocations
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
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
          title: Text(context.read<UserBloc>().state.user!.email),
        ),
        body: SafeArea(
            child: Container(
          height: height(context),
          width: width(context),
          padding: EdgeInsets.all(20.h),
          child: BlocConsumer<CreateOrderBloc, CreateOrderState>(
            listener: (context, state) {
              if (state.addingStatus == ResponseStatus.inSuccess) {
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
                showCupertinoDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const CupertinoAlertDialog(
                    title: Text('Loading...'),
                    content: CupertinoActivityIndicator(), // Loading indicator
                  ),
                );
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
                              title: Text('choose_market'.tr),
                              content: const MarketOption(),
                            ),
                            Step(
                              title: Text('choose_dates'.tr),
                              content: CalendarDatePicker2(
                                config: CalendarDatePicker2Config(
                                  calendarType: CalendarDatePicker2Type.multi,
                                ),
                                value: orderState.order.dates.cast(),
                                onValueChanged: (dates) {
                                  final OrderModel order = context
                                      .read<CreateOrderBloc>()
                                      .state
                                      .order;
                                  order.dates = dates;
                                  context
                                      .read<CreateOrderBloc>()
                                      .add(UpdateFieldsOrderEvent(order));
                                },
                              ),
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
                              final OrderModel order =
                                  context.read<CreateOrderBloc>().state.order;
                              order.referallId = context
                                  .read<UserBloc>()
                                  .state
                                  .user!
                                  .referallId;
                              order.ownerId =
                                  context.read<UserBloc>().state.user!.uid;

                              context
                                  .read<CreateOrderBloc>()
                                  .add(AddOrderEvent(order));
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
