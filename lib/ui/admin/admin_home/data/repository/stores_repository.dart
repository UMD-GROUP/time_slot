// ignore_for_file: avoid_catches_without_on_clauses

import 'package:time_slot/utils/tools/file_importers.dart';

class StoresRepository {
  StoresRepository(this.instance);
  FirebaseFirestore instance;

  Future<MyResponse> getStores(String ownerId) async {
    final MyResponse myResponse = MyResponse();
    try {
      final promoDocs = await instance
          .collection('stores')
          .where('ownerDoc', isEqualTo: ownerId)
          .get();
      myResponse
        ..statusCode = 200
        ..data =
            promoDocs.docs.map((e) => StoreModel.fromJson(e.data())).toList();
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> updateStore(StoreModel store) async {
    final MyResponse myResponse = MyResponse();

    try {
      final QuerySnapshot<Map<String, dynamic>> storeDoc = await instance
          .collection('stores')
          .where('id', isEqualTo: store.id)
          .get();
      if (storeDoc.docs.isEmpty) {
        await instance
            .collection('stores')
            .doc(store.storeDocId)
            .update(store.toJson());
        myResponse.statusCode = 200;
      } else if (storeDoc.docs.first.data()['owner']['email'] !=
          store.owner.email) {
        final StoreModel usedStore =
            StoreModel.fromJson(storeDoc.docs.first.data());
        myResponse
          ..message =
              "Bu do'kon ${usedStore.createdAt.day}.${usedStore.createdAt.month}.${usedStore.createdAt.year} da ${usedStore.owner.email}'ga rasmiylashtirilgan!"
          ..statusCode = 400;
      }
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> deleteStore(String docId) async {
    final MyResponse myResponse = MyResponse();
    try {
      await instance.collection('stores').doc(docId).delete();
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
