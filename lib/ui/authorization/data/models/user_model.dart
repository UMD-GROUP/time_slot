class UserModel {
  final String email;
  final String password;
  final String referallId;
  String fcmToken;

  UserModel(
      {required this.email,
      required this.password,
      this.fcmToken = '',
      this.referallId = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fcmToken: json["fcmToken"] ?? '',
      referallId: json["referallId"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
    );
  }

  toJson() => {
        "email": email,
        "password": password,
        "fcmToken": fcmToken,
        "referallId": referallId,
      };
}
