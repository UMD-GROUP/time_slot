import 'package:time_slot/ui/user/membership/data/models/purchase_model.dart';
import '../../../../../utils/tools/file_importers.dart';

class PurchaseRepository {
  PurchaseRepository(this.firestore);
  final FirebaseFirestore firestore;

  Future<MyResponse> getPurchases() async {
    final data = await firestore.collection('purchases').get();
    final List<PurchaseModel> result =
    data.docs.map((e) => PurchaseModel.fromJson(e.data())).toList();
    return MyResponse(data: result, statusCode: 200);
  }
}
