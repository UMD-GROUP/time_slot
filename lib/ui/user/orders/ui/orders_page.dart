import 'package:time_slot/utils/tools/file_importers.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pushNamed(context, RouteName.createOrder);
          postOrders(
            uid: context.read<UserBloc>().state.user!.uid,
            referallId: context.read<UserBloc>().state.user!.referallId,
          );
        },
      ),
    );
  }
}
