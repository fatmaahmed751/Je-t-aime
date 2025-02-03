// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  final String? userName;
  final int? userId;
  final int? rate;
  final String? message;

  ReviewModel({
    this.userName,
    this.userId,
    this.rate,
    this.message,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        userName: json["user_name"],
        userId: json["user_id"],
        rate: json["rate"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "user_id": userId,
        "rate": rate,
        "message": message,
      };
}
