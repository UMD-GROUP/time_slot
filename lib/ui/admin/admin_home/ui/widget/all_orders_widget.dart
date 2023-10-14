// ignore_for_file: cascade_invocations

import 'package:time_slot/ui/user/orders/ui/widgets/order_item.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AllOrdersWidget extends StatelessWidget {
  const AllOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == ResponseStatus.pure) {
            context.read<OrderBloc>().add(GetOrderEvent());
          } else if (state.status == ResponseStatus.inProgress) {
            return const OrderShimmerWidget();
            //const Center(child: CircularProgressIndicator(color: Colors.deepPurple,),);
          }
          if (state.status == ResponseStatus.inSuccess) {
            final List<OrderModel> curData = state.orders!.cast();
            curData.sort((a, b) => b.createdAt.compareTo(a.createdAt));

            return curData.isEmpty
                ? Center(
                    child: SizedBox(
                        height: height(context) * 0.35,
                        child: Lottie.asset(AppLotties.empty)),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: curData.length,
                        itemBuilder: (context, index) =>
                            OrderItem(order: curData[index], isAdmin: true)),
                  );
          } else {
            return const Center(
              child: Text('error'),
            );
          }
        },
      );
}
