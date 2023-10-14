// ignore_for_file: avoid_catches_without_on_clauses, cascade_invocations, avoid_positional_boolean_parameters

import 'package:time_slot/utils/tools/file_importers.dart';

class AuthorizationRepository {
  FirebaseAuth? auth;

  FirebaseAuth getAuthInstance() => auth ?? FirebaseAuth.instance;

  Future<MyResponse> signIn(UserModel user) async {
    final MyResponse myResponse = MyResponse();
    final FirebaseAuth authInstance = getAuthInstance();
    try {
      final FirebaseFirestore instance = FirebaseFirestore.instance;

      final UserCredential result =
          await authInstance.signInWithEmailAndPassword(
              email: user.email, password: user.password);
      final DocumentSnapshot<Map<String, dynamic>> userData =
          await instance.collection('users').doc(result.user!.uid).get();
      final UserModel currentUser = UserModel.fromJson(userData.data()!);
      if (currentUser.isBlocked) {
        myResponse.message = 'you_are_blocked'.tr;
      }
    } catch (e) {
      myResponse.message = e.toString().replaceAll(' ', '\n');
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          myResponse.message = 'Kiritilgan hisob mavjud emas!';
        } else if (e.code == 'wrong-password') {
          myResponse.message = 'Parol xato kiritildi!';
        } else {
          print(e);

          myResponse.message = 'Login yoki parolda xatolik mavjud!';
        }
      } else {
        print(e.toString());
        myResponse.message =
            "Server bilan muammo mavjud.\nIltimos keyinroq urinib ko'ring!";
      }
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
      referalls.add(user.token);
      if (user.referallId.isNotEmpty) {
        if (referalls.contains(user.referallId)) {
          referalls.add(user.token);
          await instance
              .collection('referalls')
              .doc('data')
              .update({'referalls': referalls});

          final QuerySnapshot<Map<String, dynamic>> referalledUser =
              await instance
                  .collection('users')
                  .where('token', isEqualTo: user.referallId)
                  .get();

          final UserModel rUser =
              UserModel.fromJson(referalledUser.docs.first.data());
          rUser.referrals.add(user.uid);
          rUser.card.referrals += 1;
          await instance
              .collection('users')
              .doc(rUser.uid)
              .update(rUser.toJson());
          await instance
              .collection('referalls')
              .doc('data')
              .update({'referalls': referalls});
        } else {
          myResponse.message = 'Siz kiritgan referall\nmavjud emas!';
          return myResponse;
        }
      } else {
        user.referallId = 'ADMIN2023';
      }
      final UserCredential result =
          await authInstance.createUserWithEmailAndPassword(
              email: user.email, password: user.password);
      user.uid = result.user!.uid;

      await instance
          .collection('users')
          .doc(result.user!.uid)
          .set(user.toJson());
      await instance
          .collection('referalls')
          .doc('data')
          .update({'referalls': referalls});

      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      myResponse.message = e.toString().tr;
      print(e.toString());
    }
    return myResponse;
  }

  Future<MyResponse> createAnAccountWithGoogle(
      UserModel user, bool isSignIn) async {
    final MyResponse myResponse = MyResponse();
    final FirebaseAuth authInstance = getAuthInstance();
    try {
      if (!isSignIn) {
        final FirebaseFirestore instance = FirebaseFirestore.instance;
        final QuerySnapshot<Map<String, dynamic>> tokens =
            await instance.collection('referalls').get();
        final List referalls = tokens.docs.first.data()['referalls'] ?? [];
        referalls.add(user.token);
        if (user.referallId.isNotEmpty) {
          if (referalls.contains(user.referallId)) {
            referalls.add(user.token);
            await instance
                .collection('referalls')
                .doc('data')
                .update({'referalls': referalls});

            final QuerySnapshot<Map<String, dynamic>> referalledUser =
                await instance
                    .collection('users')
                    .where('token', isEqualTo: user.referallId)
                    .get();

            final UserModel rUser =
                UserModel.fromJson(referalledUser.docs.first.data());
            rUser.referrals.add(user.uid);
            rUser.card.referrals += 1;
            await instance
                .collection('users')
                .doc(rUser.uid)
                .update(rUser.toJson());
            await instance
                .collection('referalls')
                .doc('data')
                .update({'referalls': referalls});
          } else {
            myResponse.message = 'Siz kiritgan referall\nmavjud emas!';
            return myResponse;
          }
        } else {
          user.referallId = 'ADMIN2023';
        }

        await instance.collection('users').doc(user.uid).set(user.toJson());
        await instance
            .collection('referalls')
            .doc('data')
            .update({'referalls': referalls});
      }

      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      myResponse.message = e.toString().tr;
      print(e.toString());
    }
    return myResponse;
  }
}
