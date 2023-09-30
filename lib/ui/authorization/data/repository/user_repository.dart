import 'package:time_slot/utils/tools/file_importers.dart';

class UserRepository {
  Future<MyResponse> getUserData(String uid) async {
    MyResponse myResponse = MyResponse();

    try {
      FirebaseFirestore instance = FirebaseFirestore.instance;

      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await instance.collection('users').doc(uid).get();
      UserModel user = UserModel.fromJson(userDoc.data() ?? {});
      myResponse.data = user;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
