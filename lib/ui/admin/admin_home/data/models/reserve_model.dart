class ReserveModel {
  ReserveModel({
    required this.date,
    this.reserve = 0,
    this.price = 0,
    this.docId = '',
    this.isNew = true,
  });

  // Factory constructor to create a ReserveModel from a JSON map
  factory ReserveModel.fromJson(Map<String, dynamic> json) => ReserveModel(
        date: DateTime.parse(json['date'] ?? '2000-01-01T00:00:00.000Z'),
        reserve: json['reserve'] as int ?? 0,
        price: json['price'] as int ?? 0,
        isNew: false,
        docId: json['docId'] as String ?? 'defaultDocId',
      );
  final DateTime date;
  int reserve;
  int price;
  final String docId;
  final bool isNew;

  // Method to convert a ReserveModel to a JSON map
  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'reserve': reserve,
        'price': price,
        'docId': docId,
      };
}
