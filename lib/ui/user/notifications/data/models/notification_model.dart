// ignore_for_file: prefer_expression_function_bodies

import 'package:hive/hive.dart';

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.createdAt,
    this.subtitle = '',
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
        isRead: json['is_read'] ?? false,
        title: json['title'] ?? '',
        body: json['body'] ?? '',
      );
  int id;
  DateTime createdAt;
  bool isRead;
  String title;
  String subtitle;
  String body;
}

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 0; // Unique ID to identify your model in Hive.

  @override
  NotificationModel read(BinaryReader reader) {
    // Deserialize your object here.
    return NotificationModel(
      id: reader.readInt(),
      createdAt: DateTime.parse(reader.readString()),
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
      ..writeString(obj.createdAt.toString())
      ..writeBool(obj.isRead)
      ..writeString(obj.title)
      ..writeString(obj.subtitle)
      ..writeString(obj.body);
  }
}
