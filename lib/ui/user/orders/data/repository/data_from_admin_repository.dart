import '../../../../../utils/tools/file_importers.dart';

class DataFromAdminRepository {
  DataFromAdminRepository(this.firestore);
  final FirebaseFirestore firestore;

  Future<MyResponse> getAdminData() async {
    final data = await firestore.collection('admin_data').get();
    final DataFromAdminModel result =
        DataFromAdminModel.fromJson(data.docs.first.data());
    return MyResponse(data: result, statusCode: 200);
  }
}
