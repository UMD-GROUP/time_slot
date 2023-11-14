// ignore_for_file: cascade_invocations

import 'package:time_slot/utils/tools/file_importers.dart';

class UsePromoCode extends StatefulWidget {
  const UsePromoCode({super.key});

  @override
  State<UsePromoCode> createState() => _UsePromoCodeState();
}

class _UsePromoCodeState extends State<UsePromoCode> {
  bool isValid = false;
  final TextEditingController promoCtrl = TextEditingController();

  void checkStatus() {
    isValid = promoCtrl.text.trim().length == 7;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<PrivilegeBloc, PrivilegeState>(
        listener: (context, state) {
          if (state.promoCodeStatus == ResponseStatus.inSuccess) {
            final OrderModel orderModel =
                context.read<CreateOrderBloc>().state.order;
            final int productCount =
                orderModel.products.fold(0, (i, e) => (i + e.count).toInt());
            if (productCount >= state.promoCode!.minAmount) {
              orderModel.promoCode = state.promoCode;
              context.read<CreateOrderBloc>().add(UpdateFieldsOrderEvent(
                  orderModel,
                  freeLimit:
                      context.read<UserAccountBloc>().state.user.freeLimits));
            } else {
              AnimatedSnackBar(
                snackBarStrategy: RemoveSnackBarStrategy(),
                duration: const Duration(seconds: 5),
                builder: (context) => AppErrorSnackBar(
                    text: 'min_limit_of_promo_code_is'.trParams(
                        {'count': state.promoCode!.minAmount.toString()})),
              ).show(context);
            }
          }
          if (state.promoCodeStatus == ResponseStatus.inFail) {
            AnimatedSnackBar(
              duration: const Duration(seconds: 5),
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppErrorSnackBar(text: state.message),
            ).show(context);
          }
        },
        builder: (context, state) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                width: width(context) * 0.35,
                alignment: Alignment.center,
                height: height(context) * 0.05,
                child: TextField(
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.characters,
                  style: AppTextStyles.labelLarge(context, fontSize: 16.sp),
                  controller: promoCtrl,
                  inputFormatters: [
                    MaxLengthInputFormatter(7),
                  ],
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    checkStatus();
                  },
                  decoration: InputDecoration(
                      hintStyle: AppTextStyles.labelLarge(context,
                          color: Colors.grey, fontSize: 20.sp),
                      border: InputBorder.none,
                      hintText: 'promo_code'.tr,
                      iconColor: Colors.deepPurple),
                )),
            SizedBox(width: width(context) * 0.05),
            state.promoCodeStatus == ResponseStatus.inProgress
                ? Container(
                    margin: EdgeInsets.only(right: height(context) * 0.06),
                    child: const CustomCircularProgressIndicator(
                        color: Colors.deepPurpleAccent),
                  )
                : TextButton(
                    onPressed: () {
                      if (isValid) {
                        context
                            .read<PrivilegeBloc>()
                            .add(GetThePromoCodeEvent(promoCtrl.text.trim()));
                      }
                    },
                    child: Text('check'.tr,
                        style: AppTextStyles.labelLarge(context,
                            color: isValid
                                ? Colors.deepPurpleAccent
                                : Colors.grey)))
          ],
        ),
      );
}
