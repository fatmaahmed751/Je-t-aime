// // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);
//
// import 'dart:convert';
//
// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
//
// String userModelToJson(UserModel data) => json.encode(data.toJson());
//
// class UserModel {
//   final User? user;
//   final String? token;
//
//   UserModel({
//     this.user,
//     this.token,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//         token: json["token"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "user": user?.toJson(),
//         "token": token,
//       };
// }
//
// class User {
//   final int? id;
//   final String? name;
//   final String? email;
//   final dynamic phone;
//   final String? image;
//
//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.image,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         image: json["image"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "image": image,
//       };
// }
class UserModel {
  final User? user;
  final String? token;

  UserModel({
    this.user,
    this.token,
  });

  // Empty instance
  // factory UserModel.empty() {
  //   return UserModel(
  //     user: User.empty(),
  //     token: '',
  //   );
  // }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final dynamic phone;
  final String? image;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  // Empty instance
  // factory User.empty() {
  //   return User(
  //     id: 0,
  //     name: '',
  //     email: '',
  //     phone: '',
  //     image: '',
  //   );
  // }

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
  };
}

