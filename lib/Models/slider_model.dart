class SliderModel {
  final int? id;
  final String? image;
  final int? categoryId;
  final String? categoryName;

  SliderModel({
    this.id,
    this.image,
    this.categoryId,
    this.categoryName,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json["id"],
        image: json["image"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
