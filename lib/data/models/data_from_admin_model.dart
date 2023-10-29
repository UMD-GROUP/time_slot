class DataFromAdminModel {
  DataFromAdminModel(
      {required this.banners,
      required this.deliveryNote,
      required this.instruction,
      required this.termsOfUsing,
      required this.maxLimit,
      required this.adminPassword,
      this.freeLimit = 0,
      this.cardNumber = '',
      required this.phoneNumber});

  factory DataFromAdminModel.fromJson(Map<String, dynamic> json) =>
      DataFromAdminModel(
          phoneNumber: json['phoneNumber'] ?? '',
          banners: json['banners'] ?? [],
          freeLimit: json['freeLimit'] ?? 0,
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
  int freeLimit;

  Map<String, dynamic> toJson() => {
        'banners': banners,
        'deliveryNote': deliveryNote,
        'instruction': instruction,
        'termsOfUsing': termsOfUsing,
        'adminPassword': adminPassword,
        'maxLimit': maxLimit,
        'phoneNumber': phoneNumber,
        'cardNumber': cardNumber,
        'freeLimit': freeLimit
      };
}
