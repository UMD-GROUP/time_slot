class BannerModel {
  BannerModel({
    required this.carusels,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        carusels: List<String>.from(json['carusels'].map((x) => x)),
      );
  List<String> carusels;
}
