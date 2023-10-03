import 'package:time_slot/ui/user/orders/data/models/banner_model.dart';

import '../../../../../utils/tools/file_importers.dart';

class OrdersRepository {
  OrdersRepository(this.firestore);
  final FirebaseFirestore firestore;

  Future<MyResponse> getOrders() async {
    final data = await firestore.collection('admin_data').get();
    final List<OrderModel> result =
    data.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    return MyResponse(data: result, statusCode: 200);
  }
}
