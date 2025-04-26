// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
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

  SearchModel({
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

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
