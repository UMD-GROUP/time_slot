// ignore_for_file: cascade_invocations

import 'package:time_slot/ui/admin/admin_home/ui/widget/all_promo_codes_widget.dart';
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
  int _currentIndex = 1;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height(context) * 0.6,
        child: ListView(
          // shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Container(
                height: height(context) * 0.06,
                decoration: BoxDecoration(
                    color: AdaptiveTheme.of(context).theme.disabledColor,
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
                        text: 'promo_codes'.tr,
                        isActive: _currentIndex == 2,
                        context: context,
                        onTap: () {
                          _onTabTapped(2);
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(height: height(context) * 0.008),
            BlocBuilder<OrderBloc, OrderState>(
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
                      ? data.toList()
                      : _currentIndex == 1
                          ? data
                              .where((e) =>
                                  e.ownerId ==
                                  context
                                      .read<UserAccountBloc>()
                                      .state
                                      .user!
                                      .uid)
                              .toList()
                          : data
                              .where((e) =>
                                  e.referralId ==
                                  context
                                      .read<UserAccountBloc>()
                                      .state
                                      .user!
                                      .token)
                              .toList();
                  curData.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                  return _currentIndex == 2
                      ? AllPromoCodesWidget()
                      : curData.isEmpty
                          ? Center(
                              child: SizedBox(
                                  height: height(context) * 0.35,
                                  child: Lottie.asset(AppLotties.empty)),
                            )
                          : ListView.builder(
                              primary: true,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: curData.length,
                              itemBuilder: (context, index) => OrderItem(
                                    order: curData[index],
                                    isAdmin: false,
                                  ));
                } else {
                  return const Center(
                    child: Text('error'),
                  );
                }
              },
            ),
          ],
        ),
      );

  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
}
