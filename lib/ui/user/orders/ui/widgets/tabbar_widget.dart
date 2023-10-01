import 'package:time_slot/ui/user/orders/ui/widgets/order_item.dart';
import 'package:time_slot/ui/user/orders/ui/widgets/tab_bar_custom_item.dart';

import '../../../../../utils/tools/file_importers.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Container(
              height: height(context) * 0.06,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(width: 0.5, color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TabBarCustomItem(
                      text: 'all',
                      isActive: _currentIndex == 0,
                      context: context,
                      onTap: () {
                        _onTabTapped(0);
                      }),
                  TabBarCustomItem(
                      text: 'mine',
                      isActive: _currentIndex == 1,
                      context: context,
                      onTap: () {
                        _onTabTapped(1);
                      }),
                  TabBarCustomItem(
                      text: 'referals',
                      isActive: _currentIndex == 2,
                      context: context,
                      onTap: () {
                        _onTabTapped(2);
                      }),
                ],
              ),
            ),
          ),
          BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status == ResponseStatus.pure) {
                context.read<OrderBloc>().add(GetOrderEvent());
              } else if (state.status == ResponseStatus.inProgress) {
                return const OrderShimmerWidget();
                //const Center(child: CircularProgressIndicator(color: Colors.deepPurple,),);
              }
              if (state.status == ResponseStatus.inSuccess) {
                final List<OrderModel> data = state.orders!.cast();

                final List<OrderModel> curData = _currentIndex == 0
                    ? data
                        .where((e) =>
                            e.ownerId ==
                                context.read<UserBloc>().state.user!.uid ||
                            e.referallId ==
                                context.read<UserBloc>().state.user!.token)
                        .toList()
                    : _currentIndex == 1
                        ? data
                            .where((e) =>
                                e.ownerId ==
                                context.read<UserBloc>().state.user!.uid)
                            .toList()
                        : data
                            .where((e) =>
                                e.referallId ==
                                context.read<UserBloc>().state.user!.token)
                            .toList();
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
                                OrderItem(order: curData[index])),
                      );
              } else {
                return const Center(
                  child: Text('error'),
                );
              }
            },
          ),
        ],
      );

  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
}
