class StoreModel {
  StoreModel({
    required this.storeDocId,
    required this.id,
    required this.name,
    required this.createdAt,
    required this.owner,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        storeDocId: json['storeDocId'] ?? '',
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(), // Provide a default DateTime if not present
        owner: StoreOwnerModel.fromJson(json['owner'] ?? {}),
      );
  final String storeDocId;
  final String id;
  final String name;
  final DateTime createdAt;
  final StoreOwnerModel owner;

  Map<String, dynamic> toJson() => {
        'storeDocId': storeDocId,
        'id': id,
        'name': name,
        'createdAt': createdAt.toIso8601String(),
        'owner': owner.toJson(),
      };
}

class StoreOwnerModel {
  StoreOwnerModel({
    required this.fcmToken,
    required this.ownerId,
    required this.email,
  });

  factory StoreOwnerModel.fromJson(Map<String, dynamic> json) =>
      StoreOwnerModel(
        fcmToken: json['fcmToken'] ?? '',
        ownerId: json['ownerId'] ?? '',
        email: json['email'] ?? '',
      );
  final String fcmToken;
  final String ownerId;
  final String email;

  Map<String, dynamic> toJson() => {
        'fcmToken': fcmToken,
        'ownerId': ownerId,
        'email': email,
      };
}
