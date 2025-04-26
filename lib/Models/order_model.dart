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
  final int? orderStatus;
  final String? address;
  final String? shippingCompany;
  final List<Product>? products;
  final String? expectedDate;

  OrderModel({
    this.id,
    this.user,
    this.orderDate,
    this.paymentMethod,
    this.totalPrice,
    this.orderStatus,
    this.address,
    this.shippingCompany,
    this.products,
    this.expectedDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    user: json["user"],
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    paymentMethod: json["payment_method"],
    totalPrice: json["total_price"],
    orderStatus: json["order_status"],
    address: json["address"],
    shippingCompany: json["shipping_company"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    expectedDate: json["expected_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "order_date": "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
    "payment_method": paymentMethod,
    "total_price": totalPrice,
    "order_status": orderStatus,
    "address": address,
    "shipping_company": shippingCompany,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "expected_date": expectedDate,
  };
}

class Product {
  final int? id;
  final String? title;
  final int? categoryId;
  final int? subcategoryId;
  final int? stock;
  final int? price;
  final int? discount;
  final int? count;
  final int? isFavorite;
  final String? image;

  Product({
    this.id,
    this.title,
    this.categoryId,
    this.subcategoryId,
    this.stock,
    this.price,
    this.discount,
    this.count,
    this.isFavorite,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    stock: json["stock"],
    price: json["price"],
    discount: json["discount"],
    count: json["count"],
    isFavorite: json["is_favorite"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "stock": stock,
    "price": price,
    "discount": discount,
    "count": count,
    "is_favorite": isFavorite,
    "image": image,
  };
}
