// To parse this JSON data, do
//
//     final cartDetailsModel = cartDetailsModelFromJson(jsonString);

import 'dart:convert';

CartDetailsModel cartDetailsModelFromJson(String str) => CartDetailsModel.fromJson(json.decode(str));

String cartDetailsModelToJson(CartDetailsModel data) => json.encode(data.toJson());

class CartDetailsModel {
  final List<Product>? products;
  final double totalPrice;
  final double shippingCost;

  CartDetailsModel({
    this.products,
    required this.totalPrice,
    required this.shippingCost,
  });

  factory CartDetailsModel.fromJson(Map<String, dynamic> json) => CartDetailsModel(
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    totalPrice: json["totalPrice"],
    shippingCost: json["shipping_cost"],
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "totalPrice": totalPrice,
    "shipping_cost": shippingCost,
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
  final int? isSelected;
  final int? qty;

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
    this.isSelected,
    this.qty,
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
    isSelected: json["is_selected"],
    qty: json["qty"],
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
    "is_selected": isSelected,
    "qty": qty,
  };
}
