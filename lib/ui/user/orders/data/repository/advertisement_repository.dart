import 'package:time_slot/ui/user/orders/data/models/banner_model.dart';

import '../../../../../utils/tools/file_importers.dart';

class AdvertisementRepository {
  AdvertisementRepository(this.firestore);
  final FirebaseFirestore firestore;

  Future<MyResponse> getBanners() async {
    final data = await firestore.collection('carusels').get();
    final List<BannerModel> result =
        data.docs.map((e) => BannerModel.fromJson(e.data())).toList();
    return MyResponse(data: result, statusCode: 200);
  }
}
