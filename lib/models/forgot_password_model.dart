// To parse this JSON data, do
//
//     final forgotPasswordModel = forgotPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordModel forgotPasswordModelFromJson(String str) => ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) => json.encode(data.toJson());

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.success=false,
    this.message="",
  });

  final bool success;
  final String message;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
    success: json["success"]??false,
    message: json["message"]??"",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
