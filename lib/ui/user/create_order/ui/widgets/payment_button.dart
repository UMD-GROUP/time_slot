import 'package:time_slot/ui/widgets/timer_button.dart';
import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, orderState) =>
            BlocBuilder<StepControllerBloc, StepControllerState>(
          builder: (context, stepState) => Visibility(
            visible: stepState.currentStep == 3,
            child: GlobalButton(
                isLoading: orderState.addingStatus == ResponseStatus.inProgress,
                onTap: () {
                  showConfirmCancelDialog(context, () {},
                      topTitle: Text(
                        'attention'.tr,
                        style: AppTextStyles.labelLarge(context,
                            color: Colors.red, fontSize: 18.sp),
                      ),
                      bottomButton: context
                              .read<DataFromAdminBloc>()
                              .state
                              .data!
                              .addStaffVideo
                              .isNotEmpty
                          ? OnTap(
                              onTap: () {
                                launchUrlString(context
                                    .read<DataFromAdminBloc>()
                                    .state
                                    .data!
                                    .addStaffVideo);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    AppImages
                                        .youtube, // Provide your Google logo image asset
                                    height: 24, // Adjust the height as needed
                                  ),
                                  const SizedBox(
                                      width:
                                          12), // Spacing between the icon and text
                                  Text(
                                    'instruction'.tr,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600, // Text color
                                      fontSize: 16, // Text font size
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : null, button: TimerButton(() {
                    Navigator.pop(context);
                    context.read<CreateOrderBloc>().add(AddOrderEvent(
                        orderState.order,
                        context.read<UserAccountBloc>().state.user!));
                  }),
                      title: 'create_order_info'.trParams({
                        'email':
                            context.read<UserAccountBloc>().state.user.email,
                        'store': context
                            .read<CreateOrderBloc>()
                            .state
                            .order
                            .marketName
                      }));
                },
                color: Colors.deepPurple,
                title: 'order'.tr,
                textColor: Colors.white),
          ),
        ),
      );
}
