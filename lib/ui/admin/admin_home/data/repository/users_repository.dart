import '../../../../../utils/tools/file_importers.dart';

class UsersRepository {
  UsersRepository(this.firestore);
  final FirebaseFirestore firestore;

  Future<MyResponse> getUsers() async {
    final data = await firestore.collection('users').get();
    final List<UserModel> result =
        data.docs.map((e) => UserModel.fromJson(e.data())).toList();
    return MyResponse(data: result, statusCode: 200);
  }
}
