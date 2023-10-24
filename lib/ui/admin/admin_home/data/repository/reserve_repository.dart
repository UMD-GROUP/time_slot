// ignore_for_file: avoid_catches_without_on_clauses, cascade_invocations
import 'package:time_slot/ui/admin/admin_home/data/models/reserve_model.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class ReserveRepository {
  final CollectionReference _reservesCollection =
      FirebaseFirestore.instance.collection('reserves');

  Future<MyResponse> createReserve(ReserveModel reserve) async {
    final MyResponse myResponse = MyResponse();

    try {
      final DocumentReference doc =
          await _reservesCollection.add(reserve.toJson());
      await doc.update({'docId': doc.id});
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }

    return myResponse;
  }

  Future<MyResponse> getAllReserves() async {
    final MyResponse myResponse = MyResponse();

    try {
      final reserves = await _reservesCollection.get();
      final List reservesList = reserves.docs;
      myResponse
        ..statusCode = 200
        ..data =
            reservesList.map((e) => ReserveModel.fromJson(e.data())).toList();
    } catch (e) {
      myResponse.message = e.toString();
    }

    return myResponse;
  }

  Future<MyResponse> updateReserve(ReserveModel newReserve) async {
    final MyResponse myResponse = MyResponse();

    try {
      await _reservesCollection
          .doc(newReserve.docId)
          .update(newReserve.toJson());
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }

    return myResponse;
  }

  Future<MyResponse> deleteReserve(String docId) async {
    final MyResponse myResponse = MyResponse();

    try {
      await _reservesCollection.doc(docId).delete();
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }

    return myResponse;
  }
}
