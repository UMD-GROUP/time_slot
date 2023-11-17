import 'package:time_slot/ui/admin/admin_home/ui/widget/promo_code_item.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class PromoCodesView extends StatelessWidget {
  PromoCodesView(this.promoCodes, {super.key});
  List<PromoCodeModel> promoCodes;

  @override
  Widget build(BuildContext context) => promoCodes.isEmpty
      ? Center(
          child: SizedBox(
              height: height(context) * 0.35,
              child: Lottie.asset(AppLotties.empty)),
        )
      : ListView.builder(
          itemCount: promoCodes.length,
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child:
                    PromoCodeItem(promoCode: promoCodes[index], isAdmin: true),
              ));
}
