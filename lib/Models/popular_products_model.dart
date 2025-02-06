// To parse this JSON data, do
//
//     final popularProductsModel = popularProductsModelFromJson(jsonString);

import 'dart:convert';

PopularProductsModel popularProductsModelFromJson(String str) =>
    PopularProductsModel.fromJson(json.decode(str));

String popularProductsModelToJson(PopularProductsModel data) =>
    json.encode(data.toJson());

class PopularProductsModel {
  final int? id;
  final String? title;
  final int? categoryId;
  final int? subcategoryId;
  final int? stock;
  final int? price;
  final int? discount;
  final int? count;
  int? isFavorite;
  final String? image;

  PopularProductsModel({
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

  factory PopularProductsModel.fromJson(Map<String, dynamic> json) =>
      PopularProductsModel(
        id: json["id"],
        title: json["title"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        stock: json["stock"],
        price: json["price"],
        discount: json["discount"],
        count: json["count"],
        isFavorite: json["is_favorite"],
        image: json["image"]??"",
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
