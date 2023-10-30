import 'package:time_slot/utils/tools/file_importers.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    if (context.read<UserAccountBloc>().state.user == null) {
      context
          .read<UserAccountBloc>()
          .add(GetUserDataEvent(FirebaseAuth.instance.currentUser!.uid));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          title: Text('Time Slot'.tr),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<UserAccountBloc>().add(
                      GetUserDataEvent(FirebaseAuth.instance.currentUser!.uid));
                  context.read<OrderBloc>().add(GetOrderEvent());
                  context.read<DataFromAdminBloc>().add(GetBannersEvent());
                  context.read<PromoCodeBloc>().add(GetPromoCodesEvent());
                  getMyToast('updated'.tr);
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: Column(children: [
            SizedBox(height: height(context) * 0.02),
            BannerCard(),
            SizedBox(height: height(context) * 0.01),
            const Expanded(child: TabBarWidget())
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add),
          onPressed: () {
            if (canNavigate(context, context.read<UserAccountBloc>().state.user,
                context.read<DataFromAdminBloc>().state.data!)) {
              context.read<CreateOrderBloc>().add(ReInitOrderEvent());
              Navigator.pushNamed(context, RouteName.createOrder);
            }
            // postOrders(
            //   uid: context.read<UserBloc>().state.user!.uid,
            //   referallId: context.read<UserBloc>().state.user!.referallId,
            // );
          },
        ),
      );
}
