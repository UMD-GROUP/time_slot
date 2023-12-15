class UserModel {
  UserModel(
      {this.email = '',
      this.password = '',
      this.markets = const [],
      this.orders = const [],
      this.referrals = const [],
      this.freeLimits = 0,
      this.createdAt,
      this.isAdmin = false,
      this.sumOfOrders = 0,
      this.isBlocked = false,
      this.language = 'uz',
      this.token = '',
      this.phoneNumber = '',
      this.isConfirmed = false,
      this.marketNumber = '',
      this.fcmToken = '',
      this.uid = '',
      this.referallId = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fcmToken: json['fcmToken'] ?? '',
        isAdmin: json['isAdmin'] ?? false,
        referallId: json['referallId'] ?? '',
        isConfirmed: json['isConfirmed'] ?? false,
        language: json['language'] ?? 'uz',
        referrals: json['referrals'] ?? [],
        sumOfOrders: json['sumOfOrders'] ?? 10,
        phoneNumber: json['phoneNumber'] ?? '',
        marketNumber: json['marketNumber'] ?? '',
        createdAt:
            DateTime.parse(json['createdAt'] ?? DateTime(2023).toString()),
        markets: json['markets'] ?? [],
        uid: json['uid'] ?? '',
        isBlocked: json['isBlocked'] ?? false,
        orders: json['orders'] ?? [],
        token: json['token'] ?? '',
        freeLimits: json['freeLimits'] ?? 0,
        email: json['email'] ?? '',
        password: json['password'] ?? '',
      );
  String email;
  final String password;
  String referallId;
  String uid;
  String token;
  List markets;
  List referrals;
  List orders;
  bool isBlocked;
  DateTime? createdAt;
  num sumOfOrders;
  String fcmToken;
  int freeLimits;
  String language;
  bool isConfirmed;
  String marketNumber;
  bool isAdmin;
  String phoneNumber;

  Map<String, Object> toJson() => {
        'markets': markets,
        'freeLimits': freeLimits,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'fcmToken': fcmToken,
        'sumOfOrders': sumOfOrders,
        'isAdmin': isAdmin,
        'token': token,
        'uid': uid,
        'isConfirmed': isConfirmed,
        'referallId': referallId,
        'orders': orders,
        'marketNumber': marketNumber,
        'referrals': referrals,
        'isBlocked': isBlocked,
        'createdAt': createdAt.toString(),
        'language': language
      };
}
