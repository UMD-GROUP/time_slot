class ProductModel {
  ProductModel({
    required this.count,
    required this.deliveryNote,
  });

  // Create a ProductModel instance from a JSON map
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        count: json['count'] as int,
        deliveryNote: json['deliveryNote'] as String,
      );

  int count;
  String deliveryNote;

  // Convert a ProductModel instance to a JSON map
  Map<String, dynamic> toJson() => {
        'count': count,
        'deliveryNote': deliveryNote,
      };
}
