import 'package:time_slot/ui/user/orders/ui/widgets/order_item.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class OrdersView extends StatelessWidget {
  OrdersView(this.orders, {super.key});
  List<OrderModel> orders;

  @override
  Widget build(BuildContext context) => orders.isEmpty
      ? Center(
          child: SizedBox(
              height: height(context) * 0.35,
              child: Lottie.asset(AppLotties.empty)),
        )
      : ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) =>
              OrderItem(order: orders[index], isAdmin: true));
}
