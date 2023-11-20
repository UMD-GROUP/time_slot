// ignore_for_file: cascade_invocations, use_build_context_synchronously

import 'dart:io';

import 'package:time_slot/ui/user/create_order/ui/widgets/use_promo_code.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        child: BlocBuilder<CreateOrderBloc, CreateOrderState>(
          builder: (context, state) => Column(
            children: [
              Visibility(
                visible:
                    state.order.freeLimit != 0 && state.order.totalSum != 0,
                child: Text('free_limits_disclaimer'.tr,
                    style: AppTextStyles.labelLarge(context,
                        color: Colors.deepPurpleAccent, fontSize: 12.sp)),
              ),
              SizedBox(height: height(context) * 0.02),
              if (state.order.totalSum != 0)
                Column(
                  children: [
                    Visibility(
                        visible: state.order.promoCode.isNull,
                        child: const UsePromoCode()),
                    SizedBox(height: height(context) * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            cardFormatter(context
                                .read<DataFromAdminBloc>()
                                .state
                                .data!
                                .cardNumber),
                            style: AppTextStyles.labelLarge(context,
                                fontSize: 26.sp)),
                        OnTap(
                            onTap: () {
                              copyToClipboard(
                                context,
                                cardFormatter(context
                                    .read<DataFromAdminBloc>()
                                    .state
                                    .data!
                                    .cardNumber),
                              );
                            },
                            child: Icon(Icons.copy,
                                color:
                                    AdaptiveTheme.of(context).theme.hintColor)),
                      ],
                    ),
                    SizedBox(height: height(context) * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height(context) * 0.13,
                          width: height(context) * 0.13,
                          decoration: BoxDecoration(
                              image: state.order.userPhoto.isNotEmpty
                                  ? DecorationImage(
                                      image: FileImage(
                                          File(state.order.userPhoto)))
                                  : null,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.deepPurple)),
                        ),
                        SizedBox(
                          width: width(context) * 0.45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.info_outlined,
                                      color: AdaptiveTheme.of(context)
                                          .theme
                                          .hintColor),
                                  SizedBox(
                                    width: width(context) * 0.38,
                                    child: Text('take_photo_info'.tr,
                                        style: AppTextStyles.labelLarge(context,
                                            fontSize: 12.sp)),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.deepPurpleAccent),
                                  ),
                                  onPressed: () async {
                                    final photo = await showPicker(context);
                                    final OrderModel order = state.order;
                                    order.userPhoto = photo!.path;
                                    context.read<CreateOrderBloc>().add(
                                        UpdateFieldsOrderEvent(
                                            order,
                                            context
                                                .read<DataFromAdminBloc>()
                                                .state
                                                .data!
                                                .orderMinAmount,
                                            freeLimit: context
                                                .read<UserAccountBloc>()
                                                .state
                                                .user
                                                .freeLimits));
                                  },
                                  child: Text(
                                    'take_photo'.tr,
                                    style: AppTextStyles.labelLarge(context,
                                        color: Colors.white, fontSize: 12.sp),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              if (state.order.totalSum == 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'it_is_free'.tr,
                      style: AppTextStyles.labelLarge(context),
                    ),
                    SizedBox(height: height(context) * 0.01),
                    Text(
                      'thanks_for_partnership'.tr,
                      style: AppTextStyles.labelLarge(context,
                          color: Colors.lightGreenAccent),
                    ),
                  ],
                )
            ],
          ),
        ),
      );
}
