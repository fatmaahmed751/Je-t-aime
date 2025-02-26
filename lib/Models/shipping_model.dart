// To parse this JSON data, do
//
//     final shippingModel = shippingModelFromJson(jsonString);

import 'dart:convert';

ShippingModel shippingModelFromJson(String str) => ShippingModel.fromJson(json.decode(str));

String shippingModelToJson(ShippingModel data) => json.encode(data.toJson());

class ShippingModel {
  final int? id;
  final String? name;
  final String? phone;
  final int? userId;
  final dynamic shippingMethod;
  final String? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ShippingModel({
    this.id,
    this.name,
    this.phone,
    this.userId,
    this.shippingMethod,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory ShippingModel.fromJson(Map<String, dynamic> json) => ShippingModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    userId: json["user_id"],
    shippingMethod: json["shipping_method"],
    address: json["address"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "user_id": userId,
    "shipping_method": shippingMethod,
    "address": address,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
