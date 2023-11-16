// ignore_for_file: avoid_catches_without_on_clauses

import 'package:time_slot/utils/tools/file_importers.dart';

class CreateOrderRepository {
  Future<MyResponse> addOrder(OrderModel order, UserModel user) async {
    final MyResponse myResponse = MyResponse();

    try {
      order
        ..referralId = user.referallId
        ..ownerId = user.uid
        ..orderId = generateRandomID(true)
        ..ownerFcm = user.fcmToken
        ..userEmail = user.email
        ..language = user.language;
      if (order.totalSum != 0) {
        order.userPhoto = await uploadImageToFirebaseStorage(order.userPhoto);
      }

      order.createdAt = DateTime.now();
      final FirebaseFirestore instance = FirebaseFirestore.instance;
      final DocumentReference<Map<String, dynamic>> orderDoc =
          await instance.collection('orders').add(order.toJson());
      await orderDoc.update({'orderDocId': orderDoc.id});
      user.orders.add(orderDoc.id);
      await instance
          .collection('users')
          .doc(user.uid)
          .update({'orders': user.orders});
      user.freeLimits -= order.freeLimit;
      await getIt<AdminRepository>().updateUser(user);
      order.reserve!.reserve -=
          order.products.fold(0, (p, e) => int.parse((p + e.count).toString()));
      await getIt<ReserveRepository>().updateReserve(order.reserve!);
      user.freeLimits -= order.freeLimit;
      await getIt<AdminRepository>().updateUser(user);
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
