import 'package:time_slot/utils/constants/form_status.dart';

class OrderModel {
  final String ownerId;
  final String referallId;
  final int orderId;
  final int productCount;
  num sum;
  String marketName;
  List<dynamic> dates;
  String userPhoto;
  OrderStatus status;
  String adminPhoto;

  OrderModel({
    required this.referallId,
    required this.ownerId,
    this.adminPhoto = '',
    required this.orderId,
    required this.productCount,
    required this.sum,
    required this.marketName,
    required this.dates,
    required this.userPhoto,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      referallId: json["referallId"] ?? '',
      adminPhoto: json["adminPhoto"] ?? '',
      ownerId: json['ownerId'] ?? '',
      orderId: json['orderId'] ?? 0,
      productCount: json['productCount'] ?? 0,
      sum: json['sum'] as num,
      marketName: json['marketName'] ?? '',
      dates: List<dynamic>.from(json['dates'] ?? []),
      userPhoto: json['userPhoto'] ?? '',
      status: OrderStatus.values[json['status'] as int],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
  }
}
