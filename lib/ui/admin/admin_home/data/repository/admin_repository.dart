// ignore_for_file: type_annotate_public_apis, avoid_catches_without_on_clauses

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_slot/data/models/data_from_admin_model.dart';
import 'package:time_slot/data/models/my_response.dart';
import 'package:time_slot/ui/common/authorization/data/models/user_model.dart';
import 'package:time_slot/ui/user/membership/data/models/purchase_model.dart';
import 'package:time_slot/ui/user/orders/data/models/order_model.dart';
import 'package:time_slot/utils/tools/assistants.dart';

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

  Future<MyResponse> updateOther(String deliveryNote, int memberPercent) async {
    final MyResponse myResponse = MyResponse();
    try {
      await instance.collection('admin_data').doc('admin_data').update(
          {'partnerPercent': memberPercent, 'deliveryNote': deliveryNote});
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> updateOrder(OrderModel order) async {
    final MyResponse myResponse = MyResponse();
    try {
      await instance
          .collection('orders')
          .doc(order.orderDocId)
          .update(order.toJson());
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
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

  Future<MyResponse> updatePurchase(PurchaseModel purchase) async {
    final MyResponse myResponse = MyResponse();

    try {
      await instance
          .collection('purchases')
          .doc(purchase.docId)
          .update(purchase.toJson());
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
