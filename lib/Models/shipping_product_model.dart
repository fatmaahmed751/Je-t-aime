// To parse this JSON data, do
//
//     final shippingProductModel = shippingProductModelFromJson(jsonString);

import 'dart:convert';

ShippingProductModel shippingProductModelFromJson(String str) => ShippingProductModel.fromJson(json.decode(str));

String shippingProductModelToJson(ShippingProductModel data) => json.encode(data.toJson());

class ShippingProductModel {
  final String? name;
  final String? quantity;
  final String? unitAmount;

  ShippingProductModel({
    this.name,
    this.quantity,
    this.unitAmount,
  });

  factory ShippingProductModel.fromJson(Map<String, dynamic> json) => ShippingProductModel(
    name: json["name"],
    quantity: json["quantity"],
    unitAmount: json["unit_amount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "unit_amount": unitAmount,
  };
}
