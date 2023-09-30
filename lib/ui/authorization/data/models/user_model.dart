class UserModel {
  final String email;
  final String password;
  final String referallId;
  final String docId;
  String token;

  UserModel(
      {required this.email,
      required this.password,
      this.token = '',
      this.docId = '',
      this.referallId = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      referallId: json["referallId"] ?? '',
      docId: json["docId"] ?? '',
      token: json["token"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
    );
  }

  toJson() => {
        "email": email,
        "password": password,
        "token": token,
        "docId": docId,
        "referallId": referallId,
      };
}
