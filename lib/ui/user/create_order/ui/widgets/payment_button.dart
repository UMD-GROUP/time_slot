import 'package:time_slot/ui/widgets/timer_button.dart';
import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, orderState) => Visibility(
          visible: orderState.order.products.isNotEmpty,
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
                        ? TextButton(
                            onPressed: () {
                              launchUrlString(context
                                  .read<DataFromAdminBloc>()
                                  .state
                                  .data!
                                  .addStaffVideo);
                            },
                            child: Text(
                              'add_staff'.tr,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.labelLarge(context,
                                  color: Colors.red),
                            ))
                        : null, button: TimerButton(() {
                  Navigator.pop(context);
                  context.read<CreateOrderBloc>().add(AddOrderEvent(
                      orderState.order,
                      context.read<UserAccountBloc>().state.user!));
                }),
                    title: 'confirm_order'.trParams({
                      'number': context
                          .read<UserAccountBloc>()
                          .state
                          .user
                          .marketNumber
                    }));
              },
              color: Colors.deepPurple,
              title: 'order'.tr,
              textColor: Colors.white),
        ),
      );
}
