class DataFromAdminModel {
  DataFromAdminModel(
      {required this.banners,
      required this.deliveryNote,
      required this.instruction,
      required this.termsOfUsing,
      required this.maxLimit,
      required this.adminPassword,
      this.cardNumber = '',
      required this.phoneNumber});

  factory DataFromAdminModel.fromJson(Map<String, dynamic> json) =>
      DataFromAdminModel(
          phoneNumber: json['phoneNumber'] ?? '',
          banners: json['banners'] ?? [],
          instruction: json['instruction'] ?? '',
          termsOfUsing: json['termsOfUsing'] ?? '',
          adminPassword: json['adminPassword'] ?? '',
          deliveryNote: json['deliveryNote'] ?? '',
          maxLimit: json['maxLimit'] ?? 0,
          cardNumber: json['cardNumber'] ?? '');
  List banners;
  String deliveryNote;
  num maxLimit;
  String instruction;
  String termsOfUsing;
  String adminPassword;
  String phoneNumber;
  String cardNumber;

  Map<String, dynamic> toJson() => {
        'banners': banners,
        'deliveryNote': deliveryNote,
        'instruction': instruction,
        'termsOfUsing': termsOfUsing,
        'adminPassword': adminPassword,
        'maxLimit': maxLimit,
        'phoneNumber': phoneNumber,
        'cardNumber': cardNumber
      };
}
