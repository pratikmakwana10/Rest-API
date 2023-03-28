// To parse this JSON data, do
//
//     final loginRecordDetailsModel = loginRecordDetailsModelFromJson(jsonString);

import 'dart:convert';

RegistrationRecModel loginRecordDetailsModelFromJson(String str) {
  return RegistrationRecModel.fromJson(json.decode(str));
}

String loginRecordDetailsModelToJson(RegistrationRecModel data) {
  return json.encode(data.toJson());
}

class RegistrationRecModel {
  RegistrationRecModel({
    this.success = false,
    required this.result,
    this.message = "",
  });

  final bool success;
  final LoginRec result;
  final String message;

  factory RegistrationRecModel.fromJson(Map<String, dynamic> json) {
    return RegistrationRecModel(
        success: json["success"],
        result: LoginRec.fromJson(json["result"]),
        message: json["message"],
      );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "result": result.toJson(),
        "message": message,
      };
}

class LoginRec {
  LoginRec({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.password = "",
    this.phoneNumber = 0,
    this.country = "",
    this.state = "",
    this.company = "",
    this.role = "",
    this.isActive = false,
    this.isLogin = false,
    this.isVerified = false,
    this.id = "",
    this.createdAt,
    this.updatedAt,
    this.v = 0,
  });

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
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  factory LoginRec.fromJson(Map<String, dynamic> json) => LoginRec(
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        phoneNumber: json["phoneNumber"] ?? 0,
        country: json["country"] ?? "",
        state: json["state"] ?? "",
        company: json["company"] ?? "",
        role: json["role"] ?? "",
        isActive: json["isActive"] ?? false,
        isLogin: json["isLogin"] ?? false,
        isVerified: json["isVerified"] ?? false,
        id: json["_id"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() {
    return {
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
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
  }
}
