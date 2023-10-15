// ignore_for_file: use_named_constants, cascade_invocations, inference_failure_on_function_invocation
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
                            if (canTapStep(
                                context,
                                context.read<CreateOrderBloc>().state.order,
                                state.currentStep + 1)) {
                              context
                                  .read<StepControllerBloc>()
                                  .add(ToNextStepEvent());
                            }
                          },
                          onStepTapped: (value) {
                            if (canTapStep(
                                context,
                                context.read<CreateOrderBloc>().state.order,
                                value)) {
                              context
                                  .read<StepControllerBloc>()
                                  .add(ToStepEvent(value));
                            }
                          },
                          connectorColor:
                              MaterialStateProperty.all(Colors.deepPurple),
                          steps: [
                            Step(
                              title: Text(
                                "${'choose_market'.tr}  ${context.read<CreateOrderBloc>().state.order.marketName}",
                                // style: AppTextStyles.labelLarge(context),
                              ),
                              content: const MarketOption(),
                            ),
                            Step(
                              title: Text(
                                "${'choose_dates'.tr}  ${context.read<CreateOrderBloc>().state.order.dates.length} ${'piece'.tr}",
                                // style: AppTextStyles.labelLarge(context),
                              ),
                              content: const SelectDatesSection(),
                            ),
                            Step(
                                title: Text(
                                    "${'products'.tr}  ${context.read<CreateOrderBloc>().state.order.products.fold(0, (previousValue, element) => previousValue + int.parse(element.count.toString()))} ${'piece'.tr}"),
                                content: const AddProductSection()),
                            Step(
                                title: BlocBuilder<CreateOrderBloc,
                                    CreateOrderState>(
                                  builder: (context, state) => Text(
                                      '${'payment'.tr}     ${state.order.products.isNotEmpty ? (context.read<DataFromAdminBloc>().state.data!.prices[state.order.dates.length - 1] * state.order.products.fold(0, (previousValue, element) => int.parse((previousValue + element.count).toString()))).toString() : ''}  ${state.order.products.isNotEmpty ? 'UZS' : ''}'),
                                ),
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
                              order.ownerId =
                                  context.read<UserBloc>().state.user!.uid;
                              order.sum = context
                                      .read<DataFromAdminBloc>()
                                      .state
                                      .data!
                                      .prices[order.dates.length - 1] *
                                  order.products.fold(
                                      0,
                                      (previousValue, element) => int.parse(
                                          (previousValue + element.count)
                                              .toString()));
                              context.read<CreateOrderBloc>().add(AddOrderEvent(
                                  order, context.read<UserBloc>().state.user!));
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
