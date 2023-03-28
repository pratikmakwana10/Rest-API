

import 'dart:convert';

import 'get_all_user_model.dart';

GetSingleUser getSingleUserFromJson(String str) => GetSingleUser.fromJson(json.decode(str));

String getSingleUserToJson(GetSingleUser data) => json.encode(data.toJson());

class GetSingleUser {
  GetSingleUser({
    this.success = false,
    this.message= "",
   required this.result,
  });

  final bool success;
  final String message;
  final AllUserResult result;

  factory GetSingleUser.fromJson(Map<String, dynamic> json) => GetSingleUser(
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    result: AllUserResult.fromJson(json["result"]?? AllUserResult(profileImg: ProfileImg()).toJson()),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result.toJson(),
  };
}

