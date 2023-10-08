// ignore_for_file: avoid_catches_without_on_clauses

import 'package:time_slot/utils/tools/file_importers.dart';

class CreateOrderRepository {
  Future<MyResponse> addOrder(OrderModel order, UserModel user) async {
    final MyResponse myResponse = MyResponse();

    try {
      order
        ..userPhoto = await uploadImageToFirebaseStorage(order.userPhoto)
        ..createdAt = DateTime.now().toUtc();
      final FirebaseFirestore instance = FirebaseFirestore.instance;
      final DocumentReference<Map<String, dynamic>> orderDoc =
          await instance.collection('orders').add(order.toJson());
      await orderDoc.update({'orderDocId': orderDoc.id});
      user.orders.add(orderDoc.id);
      await instance
          .collection('users')
          .doc(user.uid)
          .update({'orders': user.orders});
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
