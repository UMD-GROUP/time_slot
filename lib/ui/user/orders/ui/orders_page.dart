import 'package:time_slot/utils/tools/file_importers.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    if (context.read<UserBloc>().state.user == null) {
      context
          .read<UserBloc>()
          .add(GetUserDataEvent(FirebaseAuth.instance.currentUser!.uid));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          title: const Text('Orders Page'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(children: [
          SizedBox(height: height(context) * 0.02),
          BannerCard(),
          SizedBox(height: height(context) * 0.01),
          const Expanded(child: TabBarWidget())
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (canNavigate(context, context.read<UserBloc>().state.user)) {
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
