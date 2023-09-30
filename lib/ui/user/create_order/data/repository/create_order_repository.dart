// ignore_for_file: avoid_catches_without_on_clauses

import 'package:time_slot/utils/tools/file_importers.dart';

class CreateOrderRepository {
  Future<MyResponse> addOrder(OrderModel order) async {
    final MyResponse myResponse = MyResponse();

    try {
      order.userPhoto = await uploadImageToFirebaseStorage(order.userPhoto);
      final FirebaseFirestore instance = FirebaseFirestore.instance;
      await instance.collection('orders').add(order.toJson());
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
