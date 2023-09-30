class UserModel {
  final String email;
  final String password;
  final String referallId;
  String uid;
  String token;

  UserModel(
      {required this.email,
      required this.password,
      this.token = '',
      this.uid = '',
      this.referallId = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      referallId: json["referallId"] ?? '',
      uid: json["uid"] ?? '',
      token: json["token"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
    );
  }

  toJson() => {
        "email": email,
        "password": password,
        "token": token,
        "uid": uid,
        "referallId": referallId,
      };
}
