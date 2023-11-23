// ignore_for_file: use_named_constants, cascade_invocations, inference_failure_on_function_invocation
import 'package:time_slot/ui/user/create_order/ui/widgets/free_limit_widget.dart';
import 'package:time_slot/ui/user/create_order/ui/widgets/payment_button.dart';
import 'package:time_slot/ui/user/create_order/ui/widgets/select_dates_section.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple,
          title: Text(
            'create_order'.tr,
            style: AppTextStyles.labelLarge(context,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: Colors.white),
          ),
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
              child: BlocBuilder<CreateOrderBloc, CreateOrderState>(
                builder: (context, orderState) =>
                    BlocBuilder<StepControllerBloc, StepControllerState>(
                  builder: (context, state) => SingleChildScrollView(
                    child: Column(
                      children: [
                        const FreeLimitWidget(),
                        Stepper(
                            controlsBuilder: (context, details) {
                              final List backTexts = [
                                '',
                                'change_market'.tr,
                                'change_date'.tr,
                                'change_product'.tr,
                              ];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // TextButton(
                                  //   onPressed: () {
                                  //     context
                                  //         .read<StepControllerBloc>()
                                  //         .add(ToPreviousStepEvent());
                                  //   },
                                  //   child: Text(backTexts[details.currentStep],
                                  //       style: AppTextStyles.labelLarge(context,
                                  //           color: Colors.deepPurpleAccent)),
                                  // ),
                                  const SizedBox(width: 8),
                                  if (details.currentStep != 3)
                                    ElevatedButton(
                                      onPressed: () {
                                        if (canTapStep(
                                            context,
                                            orderState.order,
                                            state.currentStep + 1)) {
                                          context
                                              .read<StepControllerBloc>()
                                              .add(ToNextStepEvent());
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.deepPurpleAccent),
                                      ),
                                      child: Text(
                                        'next'.tr,
                                        style: AppTextStyles.labelLarge(context,
                                            color: Colors.white),
                                      ),
                                    ),
                                ],
                              );
                            },
                            margin: const EdgeInsets.only(left: 60),
                            currentStep: state.currentStep,
                            onStepTapped: (value) {
                              if (canTapStep(
                                  context, orderState.order, value)) {
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
                                  "${'choose_market'.tr}  ${orderState.order.marketName}",
                                  style: AppTextStyles.labelLarge(context),
                                ),
                                content: const MarketOption(),
                              ),
                              Step(
                                title: Text(
                                  "${'date'.tr}  ${orderState.order.date.isAfter(DateTime.now()) ? dateTimeToFormat(context.read<CreateOrderBloc>().state.order.date).split(' ').first : ''}",
                                  style: AppTextStyles.labelLarge(context),
                                ),
                                content: const SelectDatesSection(),
                              ),
                              Step(
                                  title: Text(
                                      "${'products'.tr}  ${orderState.order.products.fold(0, (previousValue, element) => previousValue + int.parse(element.count.toString()))} ${'piece'.tr}",
                                      style: AppTextStyles.labelLarge(context)),
                                  content: const AddProductSection()),
                              Step(
                                  title: BlocBuilder<CreateOrderBloc,
                                      CreateOrderState>(
                                    builder: (context, state) {
                                      final bool isDiscountUsed =
                                          !state.order.promoCode.isNull ||
                                              state.order.discountUsed;

                                      return Row(
                                        children: [
                                          Text('${'payment'.tr}    ',
                                              style: AppTextStyles.labelLarge(
                                                  context)),
                                          Text('${state.order.sum}  ',
                                              style: AppTextStyles.labelLarge(
                                                  isLineThrough: isDiscountUsed,
                                                  color: isDiscountUsed
                                                      ? Colors.red
                                                      : null,
                                                  context)),
                                          if (isDiscountUsed)
                                            Text(
                                              '${state.order.totalSum}',
                                              style: AppTextStyles.labelLarge(
                                                  context,
                                                  color:
                                                      Colors.lightGreenAccent),
                                            ),
                                          Text('  UZS',
                                              style: AppTextStyles.labelLarge(
                                                  context,
                                                  color: isDiscountUsed
                                                      ? Colors.lightGreenAccent
                                                      : null)),
                                        ],
                                      );
                                    },
                                  ),
                                  content: const PaymentSection())
                            ]),
                        SizedBox(height: height(context) * 0.05),
                        const PaymentButton()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )),
      );
}
