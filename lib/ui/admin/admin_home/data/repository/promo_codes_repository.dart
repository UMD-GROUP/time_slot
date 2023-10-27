// ignore_for_file: avoid_catches_without_on_clauses

import 'package:time_slot/utils/tools/file_importers.dart';

class PromoCodesRepository {
  PromoCodesRepository(this.instance);
  FirebaseFirestore instance;

  Future<MyResponse> getPromoCodes() async {
    final MyResponse myResponse = MyResponse();
    try {
      final promoDocs = await instance.collection('promo_codes').get();
      myResponse
        ..statusCode = 200
        ..data = promoDocs.docs
            .map((e) => PromoCodeModel.fromJson(e.data()))
            .toList();
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> getThePromoCode(String promoCode) async {
    final MyResponse myResponse = MyResponse();
    try {
      final promoDoc = await instance
          .collection('promo_codes')
          .where('promoCode', isEqualTo: promoCode)
          .get();
      if (promoDoc.docs.isNotEmpty) {
        myResponse
          ..statusCode = 200
          ..data = PromoCodeModel.fromJson(promoDoc.docs.first.data());
      } else {
        myResponse
          ..statusCode = 400
          ..message = 'promo_code_not_found'.tr;
      }
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> addPromoCode(PromoCodeModel promoCode) async {
    final MyResponse myResponse = MyResponse();

    try {
      final DocumentReference<Map<String, dynamic>> promoDoc =
          await instance.collection('promo_codes').add(promoCode.toJson());
      await promoDoc.update({'docId': promoDoc.id});

      final MyResponse myResponse = await getIt<UsersRepository>().getUsers();
      if (myResponse.statusCode == 200) {
        final List<UserModel> users = myResponse!.data;
        for (final UserModel user in users) {
          if (user.fcmToken.isNotEmpty) {
            await sendPushNotification(
              user.fcmToken,
              makeNotification('try_now',
                  promoCode: promoCode, language: user.language),
              makeNotification('added_new_code',
                  promoCode: promoCode, language: user.language),
            );
          }
        }
      }
      myResponse.statusCode = 200;
    } catch (e) {
      print(e.toString());
      myResponse.message = e.toString();
    }
    return myResponse;
  }

  Future<MyResponse> deletePromoCode(String docId) async {
    final MyResponse myResponse = MyResponse();
    try {
      await instance.collection('promo_codes').doc(docId).delete();
      myResponse.statusCode = 200;
    } catch (e) {
      myResponse.message = e.toString();
    }
    return myResponse;
  }
}
