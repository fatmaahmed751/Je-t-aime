// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  final String? id;
  final String? type;
  final int? typeId;
  final String? title;
  final String? description;
  final String? notifiableType;
  final int? notifiableId;
  final String? data;
   int? isRead;
  final dynamic readAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationModel({
    this.id,
    this.type,
    this.typeId,
    this.title,
    this.description,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.isRead,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    type: json["type"],
    typeId: json["type_id"],
    title: json["title"],
    description: json["description"],
    notifiableType: json["notifiable_type"],
    notifiableId: json["notifiable_id"],
    data: json["data"],
    isRead: json["is_read"],
    readAt: json["read_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "type_id": typeId,
    "title": title,
    "description": description,
    "notifiable_type": notifiableType,
    "notifiable_id": notifiableId,
    "data": data,
    "is_read": isRead,
    "read_at": readAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
