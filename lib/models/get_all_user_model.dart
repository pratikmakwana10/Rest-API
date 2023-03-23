import 'dart:convert';

AllUsersDetailsModel allUsersDetailsModelFromJson(String str) =>
    AllUsersDetailsModel.fromJson(json.decode(str));

String allUsersDetailsModelToJson(AllUsersDetailsModel data) =>
    json.encode(data.toJson());

class AllUsersDetailsModel {
  AllUsersDetailsModel({
    this.success = false,
    this.message = "",
    this.result = const [],
  });

  final bool success;
  final String message;
  final List<AllUserResult> result;

  factory AllUsersDetailsModel.fromJson(Map<String, dynamic> json) =>
      AllUsersDetailsModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        result: List<AllUserResult>.from(
            json["result"].map((x) => AllUserResult.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() =>
      {
        "success": success,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class AllUserResult {
  AllUserResult({
    this.userData = const [],
    this.totalUser = 0,
    this.currentPageRecord = 0,
    this.currentPage = 0,
    this.totalPages = 0,
  });

  final List<UserDatum> userData;
  final int totalUser;
  final int currentPageRecord;
  final int currentPage;
  final int totalPages;

  factory AllUserResult.fromJson(Map<String, dynamic> json) =>
      AllUserResult(
        userData: List<UserDatum>.from(
            json["userData"].map((x) => UserDatum.fromJson(x)) ?? []),
        totalUser: json["totalUser"] ?? 0,
        currentPageRecord: json["currentPageRecord"] ?? 0,
        currentPage: json["currentPage"] ?? 0,
        totalPages: json["totalPages"] ?? 0,
      );

  Map<String, dynamic> toJson() =>
      {
        "userData": List<dynamic>.from(userData.map((x) => x.toJson())),
        "totalUser": totalUser,
        "currentPageRecord": currentPageRecord,
        "currentPage": currentPage,
        "totalPages": totalPages,
      };
}

class UserDatum {
  UserDatum({
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.phoneNumber = 0,
    this.country = "",
    this.state = "",
    this.company = "",
    this.role = "",
    this.isActive = false,
    this.isLogin = false,
    this.isVerified = false,
    this.createdAt,
    this.updatedAt,
    this.v = 0,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
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

  factory UserDatum.fromJson(Map<String, dynamic> json) =>
      UserDatum(
        id: json["_id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        phoneNumber: json["phoneNumber"] ?? 0,
        country: json["country"] ?? "",
        state: json["state"] ?? "",
        company: json["company"] ?? "",
        role: json["role"] ?? "",
        isActive: json["isActive"] ?? false,
        isLogin: json["isLogin"] ?? false,
        isVerified: json["isVerified"] ?? false,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
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