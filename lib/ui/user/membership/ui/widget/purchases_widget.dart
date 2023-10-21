import 'package:time_slot/ui/user/membership/ui/widget/purchase_item_widget.dart';
import 'package:time_slot/ui/user/membership/ui/widget/purchase_shimmer_widget.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class PurchasesWidget extends StatelessWidget {
  const PurchasesWidget({super.key,});


  @override
  Widget build(BuildContext context) => BlocBuilder<PurchaseBloc, PurchaseState>(
      builder: (context, state) {
        if(state.status == ResponseStatus.pure){
          context.read<PurchaseBloc>().add(GetPurchasesEvent());
        }
        else if(state.status == ResponseStatus.inProgress){
          return const PurchaseShimmerWidget();
        }
        else if (state.status == ResponseStatus.inSuccess){
          final List<PurchaseModel> data = state.orders!.cast();
          final List<PurchaseModel> curData = data.where((element) => element.ownerId == context.read<UserBloc>().state.user!.uid).toList();
          return curData.isEmpty ?
              Center(child: SizedBox( height: height(context)*0.34,child: Lottie.asset(AppLotties.empty)),)
          :  Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                ...List.generate(
                    curData.length,
                        (index) => PurchasesItemWidget(purchaseModel: curData[index], isAdmin: false,))
              ],
            ),
          );
        }
        return const Center(child: Text('error'),);
      },
    );
}
