// ignore_for_file: type_annotate_public_apis, avoid_catches_without_on_clauses

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_slot/data/models/data_from_admin_model.dart';
import 'package:time_slot/data/models/my_response.dart';
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
}
