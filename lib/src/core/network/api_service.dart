import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utility/log.dart';
import '../constants/common_imports.dart';
import 'app_exceptions.dart';

class Server{
  static final Server _s = Server._();
  late http.Client _client;
  static Server get instance=> _s;
  Server._(){
    _client = http.Client();
  }

  final StreamController<String> _sessionExpireStreamController = StreamController.broadcast();
  Stream<String> get onUnauthorizedRequest => _sessionExpireStreamController.stream;

  static String get host => ApiCredential.baseUrl; //TODO must check is HOST url active for production build



  Future<dynamic> postRequest({required String url, required dynamic postData,}) async {
    try {
      var body = json.encode(postData);
      var response = await _client.post(
        Uri.parse(host + url),
        headers: {"Accept": "application/json", "Content-Type": "application/json", "Authorization": "Bearer "},
        body: utf8.encode(body),
      );
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $body");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    }
    on SocketException catch(_){
      return '{"message": "Request failed! Check internet connection.", "error": "Error message"}';
    }
    on Exception catch(_)
    {
      return '{"message": "Request failed! Unknown error occurred.", "error": "Error message"}';
    }
  }

  Future<dynamic> getRequest({required String url}) async {
    try {
      var response = await _client.get(
          Uri.parse(host + url),
          headers: {"Accept": "application/json", "Content-Type":"application/json", "Authorization": "Bearer "}
      );
      debugPrint("REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    }
    on SocketException catch(_){
      return '{"message": "Request failed! Check internet connection.", "error": "Error message"}';
    }
    on Exception catch(_)
    {
      return '{"message": "Request failed! Unknown error occurred.", "error": "Error message"}';
    }
  }

  void dispose(){
    _client.close();
    _sessionExpireStreamController.close();
  }
  dynamic _returnResponse(http.Response response) {
    appPrint("------------------------------");
    appPrint("Status Code ${response.statusCode}");
    appPrint("------------------------------");
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonEncode(response.body);
        return responseJson;
      case 201:
        var responseJson = jsonEncode(response.body);
        return responseJson;
      case 204:
        var responseJson = {'status_code': 204};
        return responseJson;
      case 400:
        var responseJson = jsonEncode(response.body);
        return responseJson;
      case 401:
        var responseJson = jsonEncode(response.body);
        return responseJson;
      case 403:
        throw UnauthorisedException(response.body);
      case 404:
        var responseJson = jsonEncode(response.body);
        return responseJson;
      case 422:
        throw ValidationException(response.body);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}


