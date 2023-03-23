
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

Network net = Network();

class Network {
  Dio dio = Dio();

  Future<dynamic> postWithDio({
    required String url,
    Map<String, dynamic> body = const {},
  }) {
    debugPrint("POST URL :: $url");
    debugPrint("POST BODY :: $body");

    return dio
        .post(
      url,
      data: body,
    )
        .then(
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

  Future<dynamic> getWithDio({
    required String url,
    Map<String, dynamic> body = const {},
  }) {
    debugPrint("GET URL :: $url");
    debugPrint("GET BODY :: $body");

    return dio
        .get(url,
            // queryParameters: body,
            options: Options(headers: {
              "Authorization":
                  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MWFmZmYyM2ZjMWU5NzBkYWQ2NzMxOCIsImlhdCI6MTY3OTU3NDgwNiwiZXhwIjoxNzExMTMyNDA2fQ.IqfLpTAZbFv4mMeQ2adS0UtEKlDPRrqbHUb5QdYLe1Y"
            }))
        .then(
      (Response response) {
        int code = response.statusCode!;
        print(response.statusCode);

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
}
