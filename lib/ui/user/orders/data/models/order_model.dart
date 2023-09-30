import 'package:time_slot/utils/constants/form_status.dart';

class OrderModel {
  OrderModel({
    this.referallId = '',
    this.ownerId = '',
    this.adminPhoto = '',
    this.orderId = 0,
    this.productCount = 0,
    this.sum = 0,
    this.marketName = '',
    required this.dates,
    this.userPhoto = '',
    this.status = OrderStatus.created,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        referallId: json['referallId'] ?? '',
        adminPhoto: json['adminPhoto'] ?? '',
        ownerId: json['ownerId'] ?? '',
        orderId: json['orderId'] ?? 0,
        productCount: json['productCount'] ?? 0,
        sum: json['sum'] as num,
        marketName: json['marketName'] ?? '',
        dates: List<dynamic>.from(json['dates'] ?? []),
        userPhoto: json['userPhoto'] ?? '',
        status: OrderStatus.values[json['status'] as int],
      );
  String ownerId;
  String referallId;
  int orderId;
  int productCount;
  num sum;
  String marketName;
  List<dynamic> dates;
  String userPhoto;
  OrderStatus status;
  String adminPhoto;

  Map<String, dynamic> toJson() => {
        'referallId': referallId,
        'adminPhoto': adminPhoto,
        'ownerId': ownerId,
        'orderId': orderId,
        'productCount': productCount,
        'sum': sum,
        'marketName': marketName,
        'dates': dates,
        'userPhoto': userPhoto,
        'status': status.index, // Store the enum as its index
      };

  OrderModel copyWith({
    String? newReferallId,
    String? newOwnerId,
    String? newAdminPhoto,
    int? newOrderId,
    int? newProductCount,
    num? newSum,
    String? newMarketName,
    List<dynamic>? newDates,
    String? newUserPhoto,
    OrderStatus? newStatus,
  }) =>
      OrderModel(
        referallId: newReferallId ?? referallId,
        ownerId: newOwnerId ?? ownerId,
        adminPhoto: newAdminPhoto ?? adminPhoto,
        orderId: newOrderId ?? orderId,
        productCount: newProductCount ?? productCount,
        sum: newSum ?? sum,
        marketName: newMarketName ?? marketName,
        dates: newDates ?? dates,
        userPhoto: newUserPhoto ?? userPhoto,
        status: newStatus ?? status,
      );
}
