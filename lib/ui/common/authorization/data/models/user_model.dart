import 'package:time_slot/ui/user/membership/data/models/banking_card_model.dart';

class UserModel {
  UserModel(
      {required this.email,
      required this.password,
      this.markets = const [],
      this.orders = const [],
      this.referrals = const [],
      this.createdAt,
      this.sumOfOrders = 0,
      required this.card,
      this.isBlocked = false,
      this.willGetPercent = true,
      this.token = '',
      this.uid = '',
      this.referallId = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        card: BankingCardModel.fromJson(json['card'] ?? {}),
        referallId: json['referallId'] ?? '',
        referrals: json['referrals'] ?? [],
        sumOfOrders: json['sumOfOrders'] ?? 10,
        createdAt:
            DateTime.parse(json['createdAt'] ?? DateTime(2023).toString()),
        markets: json['markets'] ?? [],
        uid: json['uid'] ?? '',
        isBlocked: json['isBlocked'] ?? false,
        willGetPercent: json['willGetPercent'] ?? true,
        orders: json['orders'] ?? [],
        token: json['token'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
      );
  final String email;
  final String password;
  String referallId;
  String uid;
  String token;
  List markets;
  BankingCardModel card;
  List referrals;
  List orders;
  bool isBlocked;
  bool willGetPercent;
  DateTime? createdAt;
  num sumOfOrders;

  Map<String, Object> toJson() => {
        'card': card.toJson(),
        'markets': markets,
        'email': email,
        'password': password,
        'sumOfOrders': sumOfOrders,
        'token': token,
        'uid': uid,
        'referallId': referallId,
        'orders': orders,
        'referrals': referrals,
        'willGetPercent': willGetPercent,
        'isBlocked': isBlocked,
        'createdAt': createdAt.toString()
      };
}
