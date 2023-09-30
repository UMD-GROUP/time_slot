import 'package:time_slot/ui/user/orders/data/models/product_model.dart';
import 'package:time_slot/utils/constants/form_status.dart';

class OrderModel {
  OrderModel({
    this.referallId = '',
    this.ownerId = '',
    this.adminPhoto = '',
    this.orderId = 0,
    required this.products,
    this.sum = 0,
    this.marketName = '',
    required this.dates,
    this.userPhoto = '',
    this.status = OrderStatus.created,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        referallId: json['referallId'] ?? '',
        adminPhoto: json['adminPhoto'] ?? '',
        products: json['products'].map(ProductModel.fromJson).toList(),
        ownerId: json['ownerId'] ?? '',
        orderId: json['orderId'] ?? 0,
        sum: json['sum'] as num,
        marketName: json['marketName'] ?? '',
        dates: List<dynamic>.from(json['dates'] ?? []),
        userPhoto: json['userPhoto'] ?? '',
        status: OrderStatus.values[json['status'] as int],
      );
  String ownerId;
  String referallId;
  int orderId;
  num sum;
  String marketName;
  List<dynamic> dates;
  String userPhoto;
  OrderStatus status;
  String adminPhoto;
  List<ProductModel> products;

  Map<String, dynamic> toJson() => {
        'referallId': referallId,
        'adminPhoto': adminPhoto,
        'ownerId': ownerId,
        'orderId': orderId,
        'sum': sum,
        'marketName': marketName,
        'dates': dates,
        'userPhoto': userPhoto,
        'status': status.index,
        'products': products.map((e) => e.toJson())
      };

  OrderModel copyWith({
    String? newReferallId,
    String? newOwnerId,
    String? newAdminPhoto,
    int? newOrderId,
    num? newSum,
    String? newMarketName,
    List<dynamic>? newDates,
    List<ProductModel>? products,
    String? newUserPhoto,
    OrderStatus? newStatus,
  }) =>
      OrderModel(
        products: products ?? this.products,
        referallId: newReferallId ?? referallId,
        ownerId: newOwnerId ?? ownerId,
        adminPhoto: newAdminPhoto ?? adminPhoto,
        orderId: newOrderId ?? orderId,
        sum: newSum ?? sum,
        marketName: newMarketName ?? marketName,
        dates: newDates ?? dates,
        userPhoto: newUserPhoto ?? userPhoto,
        status: newStatus ?? status,
      );
}
