// To parse this JSON data, do
//
//     final loginRecordModel = loginRecordModelFromJson(jsonString);

import 'dart:convert';

LoginRecordModel loginRecordModelFromJson(String str) => LoginRecordModel.fromJson(json.decode(str));

String loginRecordModelToJson(LoginRecordModel data) => json.encode(data.toJson());

class LoginRecordModel {
  LoginRecordModel({
    this.success=false,
   required this.result,
    this.message="",
  });

  final bool success;
  final Result result;
  final String message;

  factory LoginRecordModel.fromJson(Map<String, dynamic> json) => LoginRecordModel(
    success: json["success"]??false,
    result: Result.fromJson(json["result"]??Result(user: User()).toJson()),
    message: json["message"]??"",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result.toJson(),
    "message": message,
  };
}

class Result {
  Result({
   required this.user,
    this.token ="",
  });

  final User user;
  final String token;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    user: User.fromJson(json["user"]??User().toJson()),
    token: json["token"]??"",
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  User({
    this.id="",
    this.firstName="",
    this.lastName="",
    this.email="",
    this.password="",
    this.phoneNumber=0,
    this.country="",
    this.state="",
    this.company="",
    this.role="",
    this.isActive=false,
    this.isLogin=false,
    this.isVerified=false,
    this.createdAt,
    this.updatedAt,
    this.v=0,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final int phoneNumber;
  final String country;
  final String state;
  final String company;
  final String role;
  final bool isActive;
  final bool isLogin;
  final bool isVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"]??"",
    firstName: json["firstName"]??"",
    lastName: json["lastName"]??"",
    email: json["email"]??"",
    password: json["password"]??"",
    phoneNumber: json["phoneNumber"]??0,
    country: json["country"]??"",
    state: json["state"]??"",
    company: json["company"]??"",
    role: json["role"]??"",
    isActive: json["isActive"]??false,
    isLogin: json["isLogin"]??false,
    isVerified: json["isVerified"]??false,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"]??0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "country": country,
    "state": state,
    "company": company,
    "role": role,
    "isActive": isActive,
    "isLogin": isLogin,
    "isVerified": isVerified,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
