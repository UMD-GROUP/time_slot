import 'package:time_slot/ui/user/membership/data/models/banking_card_model.dart';

class UserModel {
  UserModel(
      {required this.email,
      required this.password,
      this.markets = const [],
      this.orders = const [],
      this.referrals = const [],
      required this.card,
      this.token = '',
      this.uid = '',
      this.referallId = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        card: BankingCardModel.fromJson(json['card'] ?? {}),
        referallId: json['referallId'] ?? '',
        referrals: json['referrals'] ?? [],
        markets: json['markets'] ?? [],
        uid: json['uid'] ?? '',
        orders: json['orders'] ?? [],
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
  final BankingCardModel card;
  List referrals;
  List orders;

  Map<String, Object> toJson() => {
        'card': card.toJson(),
        'markets': markets,
        'email': email,
        'password': password,
        'token': token,
        'uid': uid,
        'referallId': referallId,
        'orders': orders,
        'referrals': referrals
      };
}
