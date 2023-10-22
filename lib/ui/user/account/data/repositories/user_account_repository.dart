// ignore_for_file: avoid_catches_without_on_clauses

import 'package:time_slot/utils/tools/file_importers.dart';

class UserAccountRepository {
  UserAccountRepository(this.instance);
  FirebaseFirestore instance;

  Future<MyResponse> addStore(String title, UserModel user) async {
    user.markets.add(title);
    final MyResponse myResponse = MyResponse();
    try {
      await instance.collection('users').doc(user.uid).update(user.toJson());
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> addBankingCard(BankingCardModel card) async {
    final MyResponse myResponse = MyResponse();
    try {
      await instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'card': card.toJson()});
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
