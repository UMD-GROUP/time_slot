// ignore_for_file: type_annotate_public_apis, avoid_catches_without_on_clauses, cascade_invocations

import 'package:time_slot/utils/tools/file_importers.dart';

class AdminRepository {
  AdminRepository(this.instance);
  FirebaseFirestore instance;

  Future<MyResponse> addBanner(String path, DataFromAdminModel data) async {
    final MyResponse myResponse = MyResponse();
    try {
      final String url = await uploadImageToFirebaseStorage(path);
      data.banners.add(url);
      await instance
          .collection('admin_data')
          .doc('admin_data')
          .update({'banners': data.banners});
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> removeBanner(String link, DataFromAdminModel data) async {
    final MyResponse myResponse = MyResponse();
    try {
      data.banners.remove(link);
      await instance
          .collection('admin_data')
          .doc('admin_data')
          .update({'banners': data.banners});
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> updatePrices(List prices) async {
    final MyResponse myResponse = MyResponse();
    try {
      await instance
          .collection('admin_data')
          .doc('admin_data')
          .update({'prices': prices});
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> updateOther(String deliveryNote, int memberPercent,
      {DataFromAdminModel? data}) async {
    final MyResponse myResponse = MyResponse();
    try {
      if (data.isNull) {
        await instance.collection('admin_data').doc('admin_data').update(
            {'partnerPercent': memberPercent, 'deliveryNote': deliveryNote});
      } else {
        await instance
            .collection('admin_data')
            .doc('admin_data')
            .update(data!.toJson());
      }
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> updateOrder(OrderModel order, int percent,
      {String? photo}) async {
    final MyResponse myResponse = MyResponse();
    try {
      String notification = '';
      if (order.status == OrderStatus.done) {
        order.finishedAt = DateTime.now();
        notification = makeNotification('update_confirmed', order: order);
      }
      await instance
          .collection('orders')
          .doc(order.orderDocId)
          .update(order.toJson());
      if (order.status == OrderStatus.inProgress) {
        notification = 'update_is_in_progress'
            .trParams({'orderId': order.orderId.toString()});
      }
      if (order.status == OrderStatus.done) {
        final String url = await uploadImageToFirebaseStorage(photo!);
        order.adminPhoto = url;
        await instance
            .collection('orders')
            .doc(order.orderDocId)
            .update(order.toJson());
        final QuerySnapshot<Map<String, dynamic>> partnerDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .where('token', isEqualTo: order.referralId)
                .get();
        final UserModel partner =
            UserModel.fromJson(partnerDoc.docs.first.data());

        final QuerySnapshot<Map<String, dynamic>> userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: order.ownerId)
                .get();
        final UserModel user = UserModel.fromJson(userDoc.docs.first.data());
        user.sumOfOrders += order.sum;
        await instance.collection('users').doc(user.uid).update(user.toJson());
      }
      if (order.status == OrderStatus.cancelled) {
        notification = makeNotification('update_is_cancelled', order: order);
      }
      if (order.ownerFcm.isNotEmpty) {
        print('TOken bor');
        await sendPushNotification(order.ownerFcm,
            makeNotification('news_in_order', order: order), notification);
      } else {
        print('TOken yoq');
      }

      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
      print(e);
    }
    return myResponse;
  }

  Future<MyResponse> updateUser(UserModel user) async {
    final MyResponse myResponse = MyResponse();

    try {
      await instance.collection('users').doc(user.uid).update(user.toJson());
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
