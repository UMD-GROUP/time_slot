import 'package:time_slot/data/models/data_from_admin_model.dart';

import '../../../../../utils/tools/file_importers.dart';

class DataFromAdminRepository {
  DataFromAdminRepository(this.firestore);
  final FirebaseFirestore firestore;

  Future<MyResponse> getBanners() async {
    final data = await firestore.collection('admin_data').get();
    final DataFromAdminModel result =
        DataFromAdminModel.fromJson(data.docs.first.data());
    return MyResponse(data: result, statusCode: 200);
  }
}
