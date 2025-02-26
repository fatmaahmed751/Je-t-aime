// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final int? id;
  final String? user;
  final DateTime? orderDate;
  final String? paymentMethod;
  final int? totalPrice;
  final String? address;
  final String? shippingCompany;
  final String? expectedDate;
  final int? orderStatus;

  OrderModel({
    this.id,
    this.user,
    this.orderDate,
    this.paymentMethod,
    this.totalPrice,
    this.address,
    this.shippingCompany,
    this.expectedDate,
    this.orderStatus,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    user: json["user"],
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    paymentMethod: json["payment_method"],
    totalPrice: json["total_price"],
    address: json["address"],
    shippingCompany: json["shipping_company"],
    expectedDate: json["expected_date"],
    orderStatus: json["order_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "order_date": "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
    "payment_method": paymentMethod,
    "total_price": totalPrice,
    "address": address,
    "shipping_company": shippingCompany,
    "expected_date": expectedDate,
    "order_status": orderStatus,
  };
}
