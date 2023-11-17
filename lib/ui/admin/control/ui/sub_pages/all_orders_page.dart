// ignore_for_file: cascade_invocations

import 'package:time_slot/ui/admin/control/ui/sub_pages/widgets/orders_view.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AllOrdersPage extends StatelessWidget {
  const AllOrdersPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.read<OrderBloc>().add(GetOrderEvent());
                },
                icon: const Icon(Icons.refresh))
          ],
          elevation: 0,
          backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
          title: Text('orders'.tr, style: AppTextStyles.labelLarge(context)),
        ),
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        body: BlocConsumer<OrderBloc, OrderState>(
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

              return SizedBox(
                height: height(context),
                width: width(context),
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: AdaptiveTheme.of(context).theme.hintColor,
                        indicatorColor: Colors.deepPurple,
                        tabs: [
                          Tab(text: 'created'.tr),
                          Tab(text: 'in_progress'.tr),
                          Tab(text: 'finished'.tr),
                          Tab(text: 'cancelled'.tr),
                        ],
                      ),
                      SizedBox(height: height(context) * 0.02),
                      Expanded(
                        child: TabBarView(children: [
                          OrdersView(splitOrders(curData, OrderStatus.created)),
                          OrdersView(
                              splitOrders(curData, OrderStatus.inProgress)),
                          OrdersView(splitOrders(curData, OrderStatus.done)),
                          OrdersView(
                              splitOrders(curData, OrderStatus.cancelled)),
                        ]),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('error'),
              );
            }
          },
        ),
      );
}
