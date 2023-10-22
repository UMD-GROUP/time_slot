class PromoCodeModel {
  PromoCodeModel({
    required this.promoCode,
    required this.docId,
    required this.discount,
    required this.minAmount,
    required this.usedOrders,
  });

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) => PromoCodeModel(
        promoCode: json['promoCode'] ?? '',
        docId: json['docId'] ?? '',
        discount: json['discount'] ?? 0, // Provide a default value for discount
        minAmount:
            json['minAmount'] ?? 0, // Provide a default value for minAmount
        usedOrders: (json['usedOrders'] ?? [])
            .cast<String>(), // Ensure usedOrders is a List of Strings
      );
  final String promoCode;
  final String docId;
  final int discount;
  final int minAmount;
  final List usedOrders;

  Map<String, dynamic> toJson() => {
        'promoCode': promoCode,
        'docId': docId,
        'discount': discount,
        'minAmount': minAmount,
        'usedOrders': usedOrders,
      };
}
