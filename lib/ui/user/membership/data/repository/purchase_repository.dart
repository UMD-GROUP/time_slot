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

  Future<MyResponse> addPurchase(PurchaseModel purchase, UserModel user) async {
    final MyResponse myResponse = MyResponse();
    try {
      final DocumentReference doc =
          await firestore.collection('purchases').add(purchase.toJson());
      await doc.update({'docId': doc.id});

      final String uid = FirebaseAuth.instance.currentUser!.uid;
      print(purchase.amount);
      user.card!.balance -= purchase.amount;
      user.card.purchaseInProgress += purchase.amount;
      await firestore.collection('users').doc(user.uid).update(user.toJson());
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
