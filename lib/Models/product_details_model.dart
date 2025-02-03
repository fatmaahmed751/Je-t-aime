// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

import "package:je_t_aime/Models/review_model.dart";

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  final int? id;
  final int? categoryId;
  final String? categoryName;
  final int? count;
  final String? slug;
  final int? subcategoryId;
  final String? subcategoryName;
  final int? isFavorite;
  final String? title;
  final String? desc;
  final int? stock;
  final int? price;
  final int? discount;
  final List<ProductImage>? images;
  final String? averageRating;
  final ReviewModel? reviews;
  final List<RelatedProduct>? relatedProducts;

  ProductDetailsModel({
    this.id,
    this.categoryId,
    this.categoryName,
    this.count,
    this.slug,
    this.subcategoryId,
    this.subcategoryName,
    this.isFavorite,
    this.title,
    this.desc,
    this.stock,
    this.price,
    this.discount,
    this.images,
    this.averageRating,
    this.reviews,
    this.relatedProducts,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    id: json["id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    count: json["count"],
    slug: json["slug"],
    subcategoryId: json["subcategory_id"],
    subcategoryName: json["subcategory_name"],
    isFavorite: json["is_favorite"],
    title: json["title"],
    desc: json["desc"],
    stock: json["stock"],
    price: json["price"],
    discount: json["discount"],
    images: json["images"] == null ? [] : List<ProductImage>.from(json["images"]!.map((x) => ProductImage.fromJson(x))),
    averageRating: json["average_rating"],
    reviews: json["reviews"] == null ? null : ReviewModel.fromJson(json["reviews"]),
    relatedProducts: json["related_products"] == null ? [] : List<RelatedProduct>.from(json["related_products"]!.map((x) => RelatedProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "category_name": categoryName,
    "count": count,
    "slug": slug,
    "subcategory_id": subcategoryId,
    "subcategory_name": subcategoryName,
    "is_favorite": isFavorite,
    "title": title,
    "desc": desc,
    "stock": stock,
    "price": price,
    "discount": discount,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "average_rating": averageRating,
    "reviews": reviews?.toJson(),
    "related_products": relatedProducts == null ? [] : List<dynamic>.from(relatedProducts!.map((x) => x.toJson())),
  };
}

class ProductImage {
  final String? image;

  ProductImage({
    this.image,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}

class RelatedProduct {
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

  RelatedProduct({
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

  factory RelatedProduct.fromJson(Map<String, dynamic> json) => RelatedProduct(
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

