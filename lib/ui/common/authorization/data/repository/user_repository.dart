// ignore_for_file: avoid_catches_without_on_clauses

import 'package:time_slot/utils/tools/file_importers.dart';

class UserRepository {
  Future<MyResponse> getUserData(String uid) async {
    final MyResponse myResponse = MyResponse();

    try {
      final FirebaseFirestore instance = FirebaseFirestore.instance;

      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await instance.collection('users').doc(uid).get();
      final UserModel user = UserModel.fromJson(userDoc.data() ?? {});
      myResponse.data = user;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
