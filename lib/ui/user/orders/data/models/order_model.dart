import 'package:time_slot/utils/tools/file_importers.dart';

class OrderModel {
  OrderModel(
      {this.referallId = '',
      this.ownerId = '',
      this.adminPhoto = '',
      this.orderId = 0,
      this.tovarCount = 0,
      required this.products,
      this.sum = 0,
      this.marketName = '',
      required this.date,
      this.userPhoto = '',
      required this.createdAt,
      required this.finishedAt,
      this.comment = '',
      this.status = OrderStatus.created,
      this.orderDocId = ''});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        comment: json['comment'] ?? '',
        finishedAt:
            DateTime.parse(json['finishedAt'] ?? DateTime(2023).toString()),
        referallId: json['referallId'] ?? '',
        ownerId: json['ownerId'] ?? '',
        createdAt:
            DateTime.parse(json['createdAt'] ?? DateTime(2023).toString()),
        adminPhoto: json['adminPhoto'] ?? '',
        orderId: json['orderId'] as int? ?? 0,
        products: (json['products'] as List<dynamic>?)
                ?.map((e) => ProductModel.fromJson(e))
                .toList() ??
            [],
        sum: (json['sum'] as num?)?.toDouble() ?? 0.0,
        marketName: json['marketName'] ?? '',
        date: json['date'] ?? DateTime.now(),
        userPhoto: json['userPhoto'] ?? '',
        status: OrderStatus.values[json['status'] as int? ?? 0],
        orderDocId: json['orderDocId'] ?? '',
      );
  String ownerId;
  String referallId;
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
  int tovarCount;

  Map<String, dynamic> toJson() => {
        'referallId': referallId,
        'adminPhoto': adminPhoto,
        'ownerId': ownerId,
        'orderId': orderId,
        'sum': sum,
        'createdAt': createdAt.toString(),
        'finishedAt': finishedAt.toString(),
        'marketName': marketName,
        'orderDocId': orderDocId,
        'dates': date.toString(),
        'userPhoto': userPhoto,
        'status': status.index,
        'comment': comment,
        'products': products.map((e) => e.toJson())
      };
}
