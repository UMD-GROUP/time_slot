import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../../utils/tools/file_importers.dart';

class PromoCodeItem extends StatelessWidget {
  const PromoCodeItem(
      {this.isAdmin = false, super.key, required this.promoCode});
  final PromoCodeModel promoCode;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: promoCode.isVisible,
        child: ZoomTapAnimation(
          onLongTap: () {
            if (isAdmin) {
              showConfirmCancelDialog(context, () {
                Navigator.pop(context);
                context
                    .read<PromoCodeBloc>()
                    .add(DeleteCodeEvent(promoCode.docId));
              });
            }
          },
          onTap: () {
            copyToClipboard(context, promoCode.promoCode);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            width: width(context),
            decoration: BoxDecoration(
              color: AdaptiveTheme.of(context).theme.disabledColor,
              borderRadius: BorderRadius.circular(10.h),
              border: Border.all(color: Colors.deepPurple),
            ),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.all(4.h),
                    height: height(context) * 0.1,
                    width: width(context) * 0.24,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Icon(
                      Icons.discount,
                      color: Colors.white,
                    ))),
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(
                  width: width(context) * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowText(
                        icon: AppIcons.check,
                        text1: '${'promo_code'.tr} : ',
                        text2: promoCode.promoCode,
                      ),
                      RowText(
                        icon: AppIcons.dollar,
                        text1: '${'discount'.tr}:',
                        text2: '${promoCode.discount} %',
                      ),
                      RowText(
                        icon: AppIcons.check,
                        text1: 'min_count'.tr,
                        text2: '${promoCode.minAmount} ${'piece'.tr}',
                      ),
                      if (promoCode.maxUsingLimit > 0 &&
                          promoCode.maxUsingLimit !=
                              promoCode.usedOrders.length)
                        RowText(
                          iconData: Icons.change_circle_outlined,
                          icon: AppIcons.refresh,
                          text1: 'chance'.tr,
                          text2:
                              promoCode.maxUsingLimit.toString() + 'times'.tr,
                        ),
                      RowText(
                        icon: AppIcons.refresh,
                        text1: 'used'.tr,
                        text2:
                            promoCode.usedOrders.length.toString() + 'times'.tr,
                      ),
                    ],
                  ),
                ),
                isAdmin
                    ? OnTap(
                        onTap: () {
                          showConfirmCancelDialog(context, () {
                            promoCode.isVisible = !promoCode.isVisible;
                            context
                                .read<PromoCodeBloc>()
                                .add(UpdatePromoCodeEvent(promoCode));
                            Navigator.pop(context);
                          });
                        },
                        child: Icon(
                            promoCode.isVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AdaptiveTheme.of(context)
                                .theme
                                .hintColor
                                .withOpacity(0.7)))
                    : Icon(Icons.copy,
                        color: AdaptiveTheme.of(context).theme.hintColor)
              ],
            ),
          ),
        ),
      );

// ignore: non_constant_identifier_names
}
