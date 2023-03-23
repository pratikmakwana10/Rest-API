import 'dart:convert';

GetAllUsers getAllUsersFromJson(String str) =>
    GetAllUsers.fromJson(json.decode(str));

String getAllUsersToJson(GetAllUsers data) => json.encode(data.toJson());

class GetAllUsers {
  GetAllUsers({
    this.success,
    this.message,
    this.result,
  });

  final bool success;
  final String message;
  final List<Result> result;

  factory GetAllUsers.fromJson(Map<String, dynamic> json) => GetAllUsers(
        success: json["success"],
        message: json["message"],
        result:
            List<Result>.from(
                json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.userData,
    this.totalUser,
    this.currentPageRecord,
    this.currentPage,
    this.totalPages,
  });

  final List<UserDatum> userData;
  final int totalUser;
  final int currentPageRecord;
  final int currentPage;
  final int totalPages;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        userData: List<UserDatum>.from(
            json["userData"].map((x) => UserDatum.fromJson(x))),
        totalUser: json["totalUser"],
        currentPageRecord: json["currentPageRecord"],
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "userData": List<dynamic>.from(userData.map((x) => x.toJson())),
        "totalUser": totalUser,
        "currentPageRecord": currentPageRecord,
        "currentPage": currentPage,
        "totalPages": totalPages,
      };
}

class UserDatum {
  UserDatum({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.country,
    this.state,
    this.company,
    this.role,
    this.isActive,
    this.isLogin,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        country: json["country"],
        state: json["state"],
        company: json["company"],
        role: json["role"],
        isActive: json["isActive"],
        isLogin: json["isLogin"],
        isVerified: json["isVerified"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
