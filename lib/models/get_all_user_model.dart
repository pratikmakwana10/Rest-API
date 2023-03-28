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

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class AllUserResult {
  AllUserResult({
    required this.profileImg,
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
    this.v = 0,
  });

  final ProfileImg profileImg;
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
  final int v;

  factory AllUserResult.fromJson(Map<String, dynamic> json) => AllUserResult(
        profileImg: ProfileImg.fromJson(json["profileImg"]??ProfileImg().toJson()),
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
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "profileImg": profileImg.toJson(),
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
        "__v": v,
      };
}

class ProfileImg {
  ProfileImg({
    this.fileName = "",
    this.fileSize = "",
    this.publicId = "",
    this.url = "",
  });

  final String fileName;
  final String fileSize;
  final String publicId;
  final String url;

  factory ProfileImg.fromJson(Map<String, dynamic> json) => ProfileImg(
        fileName: json["fileName"],
        fileSize: json["fileSize"],
        publicId: json["public_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileSize": fileSize,
        "public_id": publicId,
        "url": url,
      };
}
