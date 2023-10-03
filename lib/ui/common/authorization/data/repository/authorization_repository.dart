// ignore_for_file: avoid_catches_without_on_clauses

import 'package:time_slot/utils/tools/file_importers.dart';

class AuthorizationRepository {
  FirebaseAuth? auth;

  FirebaseAuth getAuthInstance() => auth ?? FirebaseAuth.instance;

  Future<MyResponse> signIn(UserModel user) async {
    final MyResponse myResponse = MyResponse();
    final FirebaseAuth authInstance = getAuthInstance();
    try {
      final UserCredential result =
          await authInstance.signInWithEmailAndPassword(
              email: user.email, password: user.password);
    } catch (e) {
      myResponse.message = e.toString().replaceAll(' ', '\n');
      // if (e is FirebaseAuthException) {
      //   if (e.code == 'user-not-found') {
      //     myResponse.message = 'Kiritilgan hisob mavjud emas!';
      //   } else if (e.code == 'wrong-password') {
      //     myResponse.message = 'Parol xato kiritildi!';
      //   } else {
      //     myResponse.message =
      //         "Server bilan muammo mavjud.\nIltimos keyinroq urinib ko'ring!";
      //   }
      // } else {
      //   myResponse.message =
      //       "Server bilan muammo mavjud.\nIltimos keyinroq urinib ko'ring!";
      // }
    }
    return myResponse;
  }

  Future<MyResponse> createAnAccount(UserModel user) async {
    final MyResponse myResponse = MyResponse();
    final FirebaseAuth authInstance = getAuthInstance();
    try {
      final FirebaseFirestore instance = FirebaseFirestore.instance;
      final QuerySnapshot<Map<String, dynamic>> tokens =
          await instance.collection('referalls').get();
      final List referalls = tokens.docs.first.data()['referalls'] ?? [];
      if (referalls.contains(user.referallId)) {
        final UserCredential result =
            await authInstance.createUserWithEmailAndPassword(
                email: user.email, password: user.password);
        user.uid = result.user!.uid;

        await instance
            .collection('users')
            .doc(result.user!.uid)
            .set(user.toJson());

        referalls.add(user.token);
        await instance
            .collection('referalls')
            .doc('data')
            .update({'referalls': referalls});
      } else {
        myResponse.message = 'Siz kiritgan referall\nmavjud emas!';
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      myResponse.message = e.toString().tr;
    }
    return myResponse;
  }
}
