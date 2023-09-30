class UserModel {
  final String email;
  final String password;
  final String referallId;
  String uid;
  String token;
  List markets;

  UserModel(
      {required this.email,
      required this.password,
      this.markets = const [],
      this.token = '',
      this.uid = '',
      this.referallId = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      referallId: json["referallId"] ?? '',
      markets: json["markets"] ?? [],
      uid: json["uid"] ?? '',
      token: json["token"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
    );
  }

  toJson() => {
        "markets": markets,
        "email": email,
        "password": password,
        "token": token,
        "uid": uid,
        "referallId": referallId,
      };
}
