// ignore_for_file: avoid_catches_without_on_clauses

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

  Future<MyResponse> addPurchase(PurchaseModel purchase) async {
    final MyResponse myResponse = MyResponse();
    try {
      await firestore.collection('purchases').add(purchase.toJson());
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
