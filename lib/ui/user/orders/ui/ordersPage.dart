import 'package:time_slot/utils/tools/file_importers.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: height(context)*0.07,),
          BannerCard(),
        ],
    );
  }
}
