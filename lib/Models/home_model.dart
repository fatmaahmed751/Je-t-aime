// To parse this JSON data, do
//
//     final home = homeModelFromJson(jsonString);

import 'dart:convert';

import 'package:je_t_aime/Models/slider_model.dart';

import 'category_model.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  final String? endpointName;
  final bool? isSuccess;
  final int? statusCode;
  final String? message;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? pages;
  final Data? data;

  HomeModel({
    this.endpointName,
    this.isSuccess,
    this.statusCode,
    this.message,
    this.currentPage,
    this.total,
    this.perPage,
    this.pages,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    endpointName: json["endpointName"],
    isSuccess: json["is_success"],
    statusCode: json["status_code"],
    message: json["message"],
    currentPage: json["current_page"],
    total: json["total"],
    perPage: json["per_page"],
    pages: json["pages"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "endpointName": endpointName,
    "is_success": isSuccess,
    "status_code": statusCode,
    "message": message,
    "current_page": currentPage,
    "total": total,
    "per_page": perPage,
    "pages": pages,
    "data": data?.toJson(),
  };
}

class Data {
  final List<SliderModel>? sliders;
  final List<CategoryModel>? categories;
  final List<dynamic>? popularProducts;

  Data({
    this.sliders,
    this.categories,
    this.popularProducts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sliders: json["sliders"] == null ? [] : List<SliderModel>.from(json["sliders"]!.map((x) => SliderModel.fromJson(x))),
    categories: json["categories"] == null ? [] : List<CategoryModel>.from(json["categories"]!.map((x) => CategoryModel.fromJson(x))),
    popularProducts: json["popular_products"] == null ? [] : List<dynamic>.from(json["popular_products"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "sliders": sliders == null ? [] : List<dynamic>.from(sliders!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "popular_products": popularProducts == null ? [] : List<dynamic>.from(popularProducts!.map((x) => x)),
  };
}




