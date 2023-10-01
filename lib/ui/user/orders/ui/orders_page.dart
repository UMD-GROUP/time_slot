import 'package:time_slot/utils/tools/file_importers.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Orders Page'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            SizedBox(height: height(context)*0.02),
            BannerCard(),
            SizedBox(height: height(context)*0.01),
            const Expanded(child: TabBarWidget())
          ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.createOrder);
            // postOrders(
            //   uid: context.read<UserBloc>().state.user!.uid,
            //   referallId: context.read<UserBloc>().state.user!.referallId,
            // );
          },
        ),
      );
}


