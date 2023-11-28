import 'package:time_slot/utils/tools/file_importers.dart';

class OrderModel {
  OrderModel(
      {this.referralId = '',
      this.ownerId = '',
      this.adminPhoto = '',
      this.orderId = 0,
      this.userEmail = '',
      this.promoCode,
      this.discountUsed = false,
      this.email = ' ',
      this.password = ' ',
      required this.products,
      this.sum = 0,
      this.marketName = '',
      this.ownerToken = '',
      required this.date,
      this.userPhoto = '',
      required this.createdAt,
      required this.finishedAt,
      this.language = 'uz',
      this.reserve,
      this.totalSum = 0,
      this.freeLimit = 0,
      this.ownerFcm = '',
      this.comment = '',
      this.status = OrderStatus.created,
      this.orderDocId = ''});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        ownerFcm: json['ownerFcm'] ?? '',
        ownerToken: json['ownerToken'] ?? 'not_available'.tr,
        reserve: ReserveModel.fromJson(json['reserve'] ?? {}),
        comment: json['comment'] ?? '',
        freeLimit: json['freeLimit'] ?? 0,
        userEmail: json['userEmail'] ?? '',
        finishedAt:
            DateTime.parse(json['finishedAt'] ?? DateTime(2023).toString()),
        referralId: json['referallId'] ?? '',
        ownerId: json['ownerId'] ?? '',
        promoCode: PromoCodeModel.fromJson(json['promoCode'] ?? {}),
        createdAt:
            DateTime.parse(json['createdAt'] ?? DateTime(2023).toString()),
        adminPhoto: json['adminPhoto'] ?? '',
        orderId: json['orderId'] as int? ?? 0,
        products: (json['products'] as List<dynamic>?)
                ?.map((e) => ProductModel.fromJson(e))
                .toList() ??
            [],
        language: json['language'] ?? 'uz',
        totalSum: json['totalSum'] ?? 0,
        sum: (json['sum'] as num?)?.toDouble() ?? 0.0,
        marketName: json['marketName'] ?? '',
        date: json['date'] ?? DateTime.now(),
        userPhoto: json['userPhoto'] ?? '',
        status: OrderStatus.values[json['status'] as int? ?? 0],
        orderDocId: json['orderDocId'] ?? '',
      );
  String ownerId;
  String referralId;
  int orderId;
  num sum;
  String marketName;
  DateTime date;
  String userPhoto;
  OrderStatus status;
  String adminPhoto;
  List products;
  String orderDocId;
  DateTime createdAt;
  DateTime finishedAt;
  String comment;
  PromoCodeModel? promoCode;
  ReserveModel? reserve;
  int totalSum;
  String ownerFcm;
  String language;
  int freeLimit;
  String userEmail;
  bool discountUsed;
  String ownerToken;
  String email;
  String password;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'referallId': referralId,
        'promoCode': promoCode?.toJson(),
        'adminPhoto': adminPhoto,
        'ownerId': ownerId,
        'orderId': orderId,
        'reserve': reserve?.toJson(),
        'totalSum': totalSum,
        'sum': sum,
        'createdAt': createdAt.toString(),
        'finishedAt': finishedAt.toString(),
        'marketName': marketName,
        'orderDocId': orderDocId,
        'dates': date.toString(),
        'userEmail': userEmail,
        'userPhoto': userPhoto,
        'status': status.index,
        'comment': comment,
        'freeLimit': freeLimit,
        'language': language,
        'products': products.map((e) => e.toJson()),
        'ownerFcm': ownerFcm,
        'ownerToken': ownerToken
      };
}
