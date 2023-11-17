import '../../../../../utils/tools/file_importers.dart';

class OrdersRepository {
  OrdersRepository(this.firestore);
  final FirebaseFirestore firestore;

  Stream<List<OrderModel>> getOrdersStream() =>
      firestore.collection('orders').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => OrderModel.fromJson(doc.data())).toList());
}
