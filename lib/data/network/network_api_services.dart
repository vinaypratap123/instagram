import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:instagram/data/app_exception.dart';
import 'package:instagram/data/network/aws/aws_provider.dart';
import 'package:instagram/data/network/base_api_services.dart';
import 'package:instagram/utils/app_string.dart';

class NetworkApiServices extends BaseApiServices {
  // ******************************* GET API ********************************
  @override
  Future getGetApiResponse(String url, dynamic header) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 30));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* POST API ********************************
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: data,
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* POST API WITH HEADER ********************************
  Future getPostApiResponseHeader(String url, dynamic header) async {
    dynamic responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* POST API WITH HEADER ********************************
  Future getPostApiResponseWithHeader(
      String url, dynamic data, dynamic header) async {
    dynamic responseJson;

    try {
      final String imageUrl = '$s3Endpoint/$fileName';
      Map map;
      if (data == "") {
        map = {"content": imageUrl, "caption": ""};
      } else {
        map = {"content": imageUrl, "caption": data};
      }

      final response = await http
          .post(Uri.parse(url), body: jsonEncode(map), headers: header)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* POST API WITH HEADER ********************************
  Future getPostApiResponseWithHeaderForSignup(
      String url, dynamic data, dynamic header) async {
    dynamic responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: header)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* POST API WITH HEADER ********************************
  Future getPostApiResponseWithHeaderForNotification(
      String url, dynamic data, dynamic header) async {
    dynamic responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: header)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* POST API WITHOUT DATA ********************************
  Future getPostApiResponseWithoutData(String url, dynamic header) async {
    dynamic responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* EDIT POST API WITHOUT DATA ********************************
  Future getPostApiResponseEditPost(
      String url, dynamic data, dynamic header) async {
    dynamic responseJson;
    Map caption = {"caption": data};

    try {
      final response = await http
          .patch(Uri.parse(url), body: jsonEncode(caption), headers: header)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* EDIT POST API WITHOUT DATA ********************************
  Future getPostApiResponseEditComment(
      String url, dynamic data, dynamic header) async {
    dynamic responseJson;
    Map comment = {"comment": data};

    try {
      final response = await http
          .patch(Uri.parse(url), body: jsonEncode(comment), headers: header)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* EDIT POST API WITHOUT DATA ********************************
  Future getPostApiResponseComment(
      String url, dynamic data, dynamic header) async {
    dynamic responseJson;
    Map comment = {"comment": data};

    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(comment), headers: header)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* EDIT PROFILE API WITHOUT DATA ********************************
  Future getPostApiResponseEditProfile(
      String url, dynamic data, dynamic header) async {
    dynamic responseJson;

    try {
      final response = await http
          .patch(Uri.parse(url), body: jsonEncode(data), headers: header)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* DELETE API WITH HEADER ********************************
  Future getDeleteApi(String url, dynamic header) async {
    dynamic responseJson;

    try {
      final response = await http.delete(Uri.parse(url), headers: header);

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* POST API WITH HEADER FOR UPDATE PASSWORD ********************************
  Future getPostApiResponseWithHeaderFotUpadtePassword(
      String url, dynamic data, dynamic header) async {
    dynamic responseJson;

    try {
      final response = await http
          .patch(
            Uri.parse(url),
            body: jsonEncode(data),
            headers: header,
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

  // ******************************* SEARCH API ********************************
  Future getPostApiResponseForSearch(String url, dynamic header) async {
    dynamic responseJson;

    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: header,
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppString.noInternet);
    }
    return responseJson;
  }

// ******************************* RESPONSE STATUS CODE ********************************
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorType = errorResponse["type"];
        throw BadRequestException(errorType);
      case 404:
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorType = errorResponse["type"];
        throw UnAuthorizedException(errorType);
      case 500:
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorType = errorResponse["type"];
        throw UnAuthorizedException(errorType);
      default:
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorType = errorResponse["type"];
        throw FetchDataException(errorType);
    }
  }
}
