class DataFromAdminModel {
  DataFromAdminModel(
      {required this.banners,
      required this.deliveryNote,
      required this.prices,
      required this.instruction,
      required this.termsOfUsing,
      required this.partnerPercent,
      required this.adminPassword,
      required this.phoneNumber});

  factory DataFromAdminModel.fromJson(Map<String, dynamic> json) =>
      DataFromAdminModel(
        phoneNumber: json['phoneNumber'] ?? '',
        banners: json['banners'] ?? [],
        instruction: json['instruction'] ?? '',
        termsOfUsing: json['termsOfUsing'] ?? '',
        adminPassword: json['adminPassword'] ?? '',
        deliveryNote: json['deliveryNote'] ?? '',
        prices: json['prices'] ?? [],
        partnerPercent: json['partnerPercent'] ?? 0,
      );
  List banners;
  String deliveryNote;
  List prices;
  num partnerPercent;
  String instruction;
  String termsOfUsing;
  String adminPassword;
  String phoneNumber;

  Map<String, dynamic> toJson() => {
        'banners': banners,
        'deliveryNote': deliveryNote,
        'instruction': instruction,
        'termsOfUsing': termsOfUsing,
        'adminPassword': adminPassword,
        'prices': prices,
        'partnerPercent': partnerPercent,
        'phoneNumber': phoneNumber,
      };
}
