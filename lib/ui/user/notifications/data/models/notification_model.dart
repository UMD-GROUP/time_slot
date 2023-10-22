// ignore_for_file: prefer_expression_function_bodies

import 'package:hive/hive.dart';

class NotificationModel {
  NotificationModel({
    required this.id,
    this.isRated = false,
    this.orderId,
    required this.createdAt,
    this.subtitle = '',
    required this.type,
    required this.isRead,
    required this.title,
    required this.body,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
          id: int.parse((json['id'] ?? '0').toString()),
          // createdAt: DateTime.parse(json["created_at"] ?? ''),
          createdAt: DateTime.now(),
          subtitle: json['subtitle'] ?? '',
          type: json['type'],
          isRead: json['is_read'] ?? false,
          title: json['title'],
          orderId: int.parse(json['orderId'] ?? '-1'),
          body: json['body'],
          isRated: json['is_rated'] ?? false);
  int id;
  DateTime createdAt;
  String type;
  bool isRead;
  String title;
  String subtitle;
  String body;
  int? orderId;
  bool isRated;
}

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 0; // Unique ID to identify your model in Hive.

  @override
  NotificationModel read(BinaryReader reader) {
    // Deserialize your object here.
    return NotificationModel(
      id: reader.readInt(),
      orderId: reader.readInt(),
      isRated: reader.readBool(),
      createdAt: DateTime.parse(reader.readString()),
      type: reader.readString(),
      isRead: reader.readBool(),
      title: reader.readString(),
      subtitle: reader.readString(),
      body: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    // Serialize your object here.
    writer
      ..writeInt(obj.id)
      ..writeInt(obj.orderId!)
      ..writeBool(obj.isRated)
      ..writeString(obj.createdAt.toString())
      ..writeString(obj.type)
      ..writeBool(obj.isRead)
      ..writeString(obj.title)
      ..writeString(obj.subtitle)
      ..writeString(obj.body);
  }
}
