import 'package:time_slot/utils/tools/file_importers.dart';

class AuthorizationRepository {
  FirebaseAuth? auth;

  FirebaseAuth getAuthInstance() => auth ?? FirebaseAuth.instance;

  Future<MyResponse> signIn(UserModel user) async {
    MyResponse myResponse = MyResponse();
    FirebaseAuth authInstance = getAuthInstance();
    try {
      UserCredential result = await authInstance.signInWithEmailAndPassword(
          email: user.email, password: user.password);
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "user-not-found") {
          myResponse.message = "Kiritilgan hisob mavjud emas!";
        } else if (e.code == "wrong-password") {
          myResponse.message = "Parol xato kiritildi!";
        } else {
          myResponse.message =
              "Server bilan muammo mavjud.\nIltimos keyinroq urinib ko'ring!";
        }
      } else {
        myResponse.message =
            "Server bilan muammo mavjud.\nIltimos keyinroq urinib ko'ring!";
      }
    }
    return myResponse;
  }

  Future<MyResponse> createAnAccount(UserModel user) async {
    MyResponse myResponse = MyResponse();
    FirebaseAuth authInstance = getAuthInstance();
    try {
      FirebaseFirestore instance = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> tokens =
          await instance.collection("referalls").get();
      List referalls = tokens.docs.first.data()["referalls"] ?? [];
      if (referalls.contains(user.referallId)) {
        UserCredential result =
            await authInstance.createUserWithEmailAndPassword(
                email: user.email, password: user.password);

        DocumentReference doc =
            await instance.collection("users").add(user.toJson());
        doc.update({"docId": doc.id});

        referalls.add(user.token);
        await instance
            .collection('referalls')
            .doc("data")
            .update({"referalls": referalls});
      } else {
        myResponse.message = "Siz kiritgan referall\nmavjud emas!";
      }
    } catch (e) {
      print("MAnA error $e");
      myResponse.message =
          "Server bilan muammo mavjud.\nIltimos keyinroq urinib ko'ring!";
    }
    return myResponse;
  }
}
