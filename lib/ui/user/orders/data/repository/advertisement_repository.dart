import 'package:time_slot/ui/user/orders/data/models/banner_model.dart';
import '../../../../../utils/tools/file_importers.dart';

class AdvertisementRepository {
  final FirebaseFirestore firestore;
  AdvertisementRepository(this.firestore);


  Future<MyResponse> getBanners() async{
    var data  = await firestore.collection("carusels").get();
    List<BannerModel> result =  data.docs.map((e) => BannerModel.fromJson(e.data())).toList();
    return MyResponse(data: result,statusCode: 200);
  }

}
