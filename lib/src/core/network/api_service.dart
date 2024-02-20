import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../feature/authentication/data/data_sources/remote/auth_data_source.dart';
import '../utility/log.dart';
import '../service/auth_cache_manager.dart';
import '../constants/common_imports.dart';
import 'app_exceptions.dart';

class Server {
  static final Server _s = Server._();
  late http.Client _client;
  static Server get instance => _s;
  Server._() {
    _client = http.Client();
  }

  final StreamController<String> _sessionExpireStreamController =
      StreamController.broadcast();
  Stream<String> get onUnauthorizedRequest =>
      _sessionExpireStreamController.stream;

  static String get host => ApiCredential
      .baseUrl; //TODO must check is HOST url active for production build

  Future<dynamic> postRequest({
    required String url,
    required dynamic postData,
  }) async {
    try {
      var body = json.encode(postData);
      String token = await AuthCacheManager.getUserToken();
      var response = await _client.post(
        Uri.parse(host + url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: utf8.encode(body),
      );
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $body");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      return '{"message": "Request failed! Check internet connection.", "error": "Error message"}';
    } on Exception catch (_) {
      return '{"message": "Request failed! Unknown error occurred.", "error": "Error message"}';
    }
  }

  Future<dynamic> getRequestForAuth({required String url}) async {
    try {
      String token = await AuthCacheManager.getUserToken();
      // var response = await _client.get(Uri.parse(host + url), headers: {
      //   "Accept": "application/json",
      //   "Content-Type": "application/json",
      //   "Authorization": "Bearer $token"
      // });

      var response = await RetryClient(
        _client,
        retries: 1,
        when: (response) {
          print("When");
          return response.statusCode == 400;
        },
        onRetry: (req, res, retryCount) async {
          if (res?.statusCode == 400) {
            await AuthRemoteDataSourceImp().refreshTokenAction();
            // remove old token
            req.headers.remove('Authorization');
            print("onRetry");
            // add new token
            String token = await AuthCacheManager.getUserToken();
            Map<String, String> tokenHeader = {"Authorization": "Bearer $token"};
            req.headers.addEntries(tokenHeader.entries);
          }
        },
      ).get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      dynamic response = {
        "message": "Request failed! Check internet connection.",
        "error": "Error message"
      };
      return response;
    } on Exception catch (_) {
      dynamic response = {
        "message": "Request failed! Unknown error occurred.",
        "error": "Error message"
      };
      return response;
    }
  }

  Future<dynamic> postRequestForAuth({required String url}) async {
    try {
      String token = await AuthCacheManager.getUserToken();
      // var response = await _client.get(Uri.parse(host + url), headers: {
      //   "Accept": "application/json",
      //   "Content-Type": "application/json",
      //   "Authorization": "Bearer $token"
      // });

      var response = await RetryClient(
        _client,
        retries: 1,
        when: (response) {
          print("When");
          return response.statusCode == 400;
        },
        onRetry: (req, res, retryCount) async {
          if (res?.statusCode == 400) {
            String refreshToken = await AuthCacheManager.getRefreshToken();
            req.headers.remove('Authorization');
            Map<String, String> refreshTokenHeader = {"Authorization": "Bearer $refreshToken"};
            req.headers.addEntries(refreshTokenHeader.entries);
            await AuthRemoteDataSourceImp().refreshTokenAction();
            // remove old token
            req.headers.remove('Authorization');
            print("onRetry");
            // add new token
            String token = await AuthCacheManager.getUserToken();
            Map<String, String> tokenHeader = {"Authorization": "Bearer $token"};
            req.headers.addEntries(tokenHeader.entries);
          }
        },
      ).post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      dynamic response = {
        "message": "Request failed! Check internet connection.",
        "error": "Error message"
      };
      return response;
    } on Exception catch (_) {
      dynamic response = {
        "message": "Request failed! Unknown error occurred.",
        "error": "Error message"
      };
      return response;
    }
  }

  Future<dynamic> getRequest({required String url}) async {
    try {
      String token = await AuthCacheManager.getUserToken();
      var response = await _client.get(Uri.parse(host + url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      dynamic response = {
        "message": "Request failed! Check internet connection.",
        "error": "Error message"
      };
      return response;
    } on Exception catch (_) {
      dynamic response = {
        "message": "Request failed! Unknown error occurred.",
        "error": "Error message"
      };
      return response;
    }
  }

  ///Todo must be modify later
  // Future<dynamic> getRequestForAuth({required String url}) async {
  //   try {
  //     String token = await AuthCacheManager.getUserToken();
  //     var response = await _client.get(Uri.parse(url), headers: {
  //       "Accept": "application/json",
  //       "Content-Type": "application/json",
  //       "Authorization":
  //           "Bearer $token"
  //     });
  //     debugPrint(
  //         "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
  //     return _returnResponse(response);
  //   } on SocketException catch (_) {
  //     dynamic response = {
  //       "message": "Request failed! Check internet connection.",
  //       "error": "Error message"
  //     };
  //     return response;
  //   } on Exception catch (_) {
  //     dynamic response = {
  //       "message": "Request failed! Unknown error occurred.",
  //       "error": "Error message"
  //     };
  //     return response;
  //   }
  // }

  Future<dynamic> deleteRequest({required String url}) async {
    try {
      String token = await AuthCacheManager.getUserToken();
      var response = await _client.delete(Uri.parse(host + url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      dynamic response = {
        "message": "Request failed! Check internet connection.",
        "error": "Error message"
      };
      return response;
    } on Exception catch (_) {
      dynamic response = {
        "message": "Request failed! Unknown error occurred.",
        "error": "Error message"
      };
      return response;
    }
  }

  void dispose() {
    _client.close();
    _sessionExpireStreamController.close();
  }

  dynamic _returnResponse(http.Response response) {
    appPrint("------------------------------");
    appPrint("Status Code ${response.statusCode}");
    appPrint("------------------------------");
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 201:
        return json.decode(response.body);
      case 204:
        return json.decode(response.body);
      case 400:
        return json.decode(response.body);
      case 401:
        return json.decode(response.body);
      case 403:
        throw UnauthorisedException(response.body);
      case 404:
        return json.decode(response.body);
      case 422:
        return json.decode(response.body);
      case 500:
        return json.decode(response.body);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
