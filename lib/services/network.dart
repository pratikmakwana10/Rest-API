import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Network net = Network();

class Network {
  Dio dio = Dio();

  Future<dynamic> postWithDio({
    required String url,
    Map<String, dynamic> body = const {},
  }) {
    debugPrint("POST URL :: $url");
    debugPrint("POST BODY :: $body");

    return dio.post(url, data: body,).then(
      (Response response) {
        int code = response.statusCode!;

        if (code < 200 || code > 400) {
          /// HANDEL STATUS
        }

        print(code.toString());

        return response.data;
      },
    ).catchError((error) {
      debugPrint(error.toString());
      return SnackBar(content: error);
    });
  }
  Future<dynamic> postWithDioWithFormData({
    required String url,
    required FormData formData,
  }) {
    debugPrint("POST URL :: $url");

    return dio.post(url, data: formData,).then(
      (Response response) {
        int code = response.statusCode!;

        if (code < 200 || code > 400) {
          /// HANDEL STATUS
        }

        print(code.toString());

        print(response.data);
        return response.data;
      },
    ).catchError((error) {
      debugPrint(error.toString());
      return SnackBar(content: error);
    });
  }

  void setApiKeyAndToken({
    required String token,
  }) {
    dio.options.headers.addAll({
      "Authorization": "Bearer $token",
    });

    debugPrint(
        "======= SUCCESS :: TOKEN SET SUCCESSFULLY ======= ::::: TOKEN :: $token");
  }

  Future<dynamic> getWithDio({
    required String url,
    Map<String, dynamic> body = const {},
  }) {
    debugPrint("GET URL :: $url");
    debugPrint("GET BODY :: $body");

    return dio
        .get(url,
            // queryParameters: body,
            options: Options(headers: {}))
        .then(
      (Response response) {
        int code = response.statusCode!;
             if (code < 200 || code > 400) {
          /// HANDEL STATUS
        }

        return response.data;
      },
    ).onError(
      (error, stackTrace) {
        print("ERROR :: $error");
      },
    ).catchError((error) {
      print(error.toString());
      debugPrint(error);
    });
  }
  Future<dynamic> putWithDio({
    required String url,
    Map<String, dynamic> body = const {},
  }) {
    debugPrint("POST URL :: $url");
    debugPrint("POST BODY :: $body");

    return dio.put(url, data: body,).then(
          (Response response) {
        int code = response.statusCode!;

        if (code < 200 || code > 400) {
          /// HANDEL STATUS
        }

        print(code.toString());

        return response.data;
      },
    ).catchError((error) {
      debugPrint(error.toString());
    });
  }
  Future<dynamic> deleteWithDio({
    required String url,
  }) {
    debugPrint("POST URL :: $url");

    return dio.delete(url).then(
          (Response response) {
        int code = response.statusCode!;

        if (code < 200 || code > 400) {
          /// HANDEL STATUS
        }

        print(code.toString());

        return response.data;
      },
    ).catchError((error) {
      debugPrint(error.toString());
    });
  }
}
