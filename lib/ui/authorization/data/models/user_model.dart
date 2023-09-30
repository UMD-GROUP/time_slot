class UserModel {
  UserModel(
      {required this.email,
      required this.password,
      this.markets = const [],
      this.token = '',
      this.uid = '',
      this.referallId = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        referallId: json['referallId'] ?? '',
        markets: json['markets'] ?? [],
        uid: json['uid'] ?? '',
        token: json['token'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
      );
  final String email;
  final String password;
  final String referallId;
  String uid;
  String token;
  List markets;

  Map<String, Object> toJson() => {
        'markets': markets,
        'email': email,
        'password': password,
        'token': token,
        'uid': uid,
        'referallId': referallId,
      };
}
