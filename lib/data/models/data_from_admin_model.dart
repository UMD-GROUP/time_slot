class DataFromAdminModel {
  DataFromAdminModel({
    required this.banners,
    required this.deliveryNote,
    required this.prices,
    required this.partnerPercent,
  });

  factory DataFromAdminModel.fromJson(Map<String, dynamic> json) =>
      DataFromAdminModel(
        banners: json['banners'] ?? [],
        deliveryNote: json['deliveryNote'] ?? '',
        prices: json['prices'] ?? [],
        partnerPercent: json['partnerPercent'] ?? 0,
      );
  List banners;
  String deliveryNote;
  List prices;
  num partnerPercent;

  Map<String, dynamic> toJson() => {
        'banners': banners,
        'deliveryNote': deliveryNote,
        'prices': prices,
        'partnerPercent': partnerPercent,
      };
}
