import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:practice_backend/repository/api_const.dart';
import 'package:practice_backend/repository/api_response.dart';
import 'package:practice_backend/utils/utils.dart';

class ApiRepository {
  static Dio dioClient = Dio();

  static Future<ApiResponse> getApi(String apiRoute,
      {String token = ""}) async {
    if (await Utils.isInternetConnected()) {
      try {
        String callUrl = ApiConst.BASE_URL + apiRoute;
        debugPrint("-------------------------");
        debugPrint("url:-------------- ${callUrl}");
        debugPrint("token:------------ ${token}");

        if (token.isNotEmpty) {
          dioClient.options.headers["authorization"] =
              token; //"Bearer " + token;
        }

        var response = await dioClient.get(callUrl);
        debugPrint(
            "----------------------ApiRepository--getAPI----------$response");

        if (response.statusCode == 200 || response.statusCode == 201) {
          return ApiResponse(
              status: true,
              statusCode: "200",
              message: "Success",
              data: response.data);
        } else if (response.statusCode == 503) {
          debugPrint("----------------------------------api repository 503 ");
          return ApiResponse(
              status: false, statusCode: "503", message: "Server Down");
        } else {
          debugPrint("----------------------------------api repository 500");
          return ApiResponse(
              status: false,
              statusCode: "500",
              message: "Something went wrong");
        }
      } on DioException catch (e) {
        return exceptionOccured(e);
      }
    } else {
      return ApiResponse(
          status: false, statusCode: "144", message: "No Internet Connection");
    }
  }

  static Future<dynamic> deleteAPI(String apiRoute, {String token = ""}) async {
    if (await Utils.isInternetConnected()) {
      try {
        String callUrl = ApiConst.BASE_URL + apiRoute;
        debugPrint("-------------------------");
        debugPrint("url:-------------- ${callUrl}");
        debugPrint("token:------------ ${token}");

        if (token.isNotEmpty) {
          dioClient.options.headers["authorization"] =
              token; //"Bearer " + token;
        }

        var response = await dioClient.delete(callUrl);
        debugPrint(
            "----------------------ApiRepository--getAPI----------$response");

        if (response.statusCode == 200 || response.statusCode == 201) {
          return ApiResponse(
              status: true,
              statusCode: "200",
              message: "Success",
              data: response.data);
        } else if (response.statusCode == 503) {
          debugPrint("----------------------------------api repository 503 ");
          return ApiResponse(
              status: false, statusCode: "503", message: "Server Down");
        } else {
          debugPrint("----------------------------------api repository 500");
          return ApiResponse(
              status: false,
              statusCode: "500",
              message: "Something went wrong");
        }
      } on DioException catch (e) {
        return exceptionOccured(e);
      }
    } else {
      return ApiResponse(
          status: false, statusCode: "144", message: "No Internet Connection");
    }
  }

  static Future<ApiResponse> postAPI(String apiRoute, var formData,
      {String token = ""}) async {
    if (await Utils.isInternetConnected()) {
      try {
        String callUrl = ApiConst.BASE_URL + apiRoute;
        debugPrint("-------------------------");
        debugPrint("url:-------------- $callUrl");
        debugPrint("token:------------ $token");
        debugPrint("data eeee:-------------- ${formData.toString()}");
        debugPrint("-------------------------");

        if (token.isNotEmpty) {
          dioClient.options.headers["authorization"] =
              token; //"Bearer " + token;
        }

        dioClient.options.headers["Content-Type"] = "application/json";
        dioClient.options.headers["Accept"] = "application/json";
        dioClient.options.headers["Accept-Language"] = "en";

        var response = await dioClient.post(callUrl, data: formData);
        // response come when status is 200 only
        debugPrint(
            "----------------------ApiRepository--postAPI----------$response");
        // return response;
        if (response.statusCode == 200 || response.statusCode == 201) {
          return ApiResponse(
              status: true,
              statusCode: "200",
              message: "Success",
              data: response.data);
        } else if (response.statusCode == 503) {
          debugPrint("----------------------------------api repository 503 ");
          return ApiResponse(
              status: false, statusCode: "503", message: "Server Down");
        } else {
          debugPrint("----------------------------------api repository 500");
          return ApiResponse(
              status: false,
              statusCode: "500",
              message: "Something went wrong");
        }
      } on DioException catch (e) {
        return exceptionOccured(e);
      }
    } else {
      return ApiResponse(
          status: false, statusCode: "144", message: "No Internet Connection");
    }
  }

  static Future<ApiResponse> putAPI(String apiRoute, var formData,
      {String token = ""}) async {
    if (await Utils.isInternetConnected()) {
      try {
        String callUrl = ApiConst.BASE_URL + apiRoute;
        debugPrint("-------------------------");
        debugPrint("url:-------------- $callUrl");
        debugPrint("token:------------ $token");
        debugPrint("data eeee:-------------- ${formData.toString()}");
        debugPrint("-------------------------");

        if (token.isNotEmpty) {
          dioClient.options.headers["authorization"] =
              token; //"Bearer " + token;
        }

        dioClient.options.headers["Content-Type"] = "application/json";
        dioClient.options.headers["Accept"] = "application/json";
        dioClient.options.headers["Accept-Language"] = "en";

        var response = await dioClient.put(callUrl, data: formData);
        // response come when status is 200 only
        debugPrint(
            "----------------------ApiRepository--postAPI----------$response");
        // return response;
        if (response.statusCode == 200 || response.statusCode == 201) {
          return ApiResponse(
              status: true,
              statusCode: "200",
              message: "Success",
              data: response.data);
        } else if (response.statusCode == 503) {
          debugPrint("----------------------------------api repository 503 ");
          return ApiResponse(
              status: false, statusCode: "503", message: "Server Down");
        } else {
          debugPrint("----------------------------------api repository 500");
          return ApiResponse(
              status: false,
              statusCode: "500",
              message: "Something went wrong");
        }
      } on DioException catch (e) {
        return exceptionOccured(e);
      }
    } else {
      return ApiResponse(
          status: false, statusCode: "144", message: "No Internet Connection");
    }
  }

  static exceptionOccured(DioException e) {
    Map<String, dynamic>? response;
    if (e.response != null) {
      print("-------response response----${e.response}");
      try {
        response = e.response?.data;
      } catch (e) {
        response = null; // "Something Went Wrong";
      }
    }

    //todo: other Exception code come here or message return
    if (response != null) {
      return ApiResponse(
          status: false,
          statusCode: e.response?.statusCode.toString() ?? "500",
          message:
              "${response.containsKey("error") ? response["error"] : response["message"]}");
    } else {
      return ApiResponse(
          status: false, statusCode: "500", message: "${e.message}");
    }
  }
}
