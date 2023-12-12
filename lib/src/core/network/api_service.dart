// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
//
// import '../constants/urls.dart';
// import '../di/dependency_injection.dart';
// import '../utility/log.dart';
// import 'app_exceptions.dart';
// import 'http_client.dart';
//
// class ApiService {
//   final BaseHttpClient _baseClient = locator.get<BaseHttpClient>();
//
//   Future<dynamic> getRequest(String url) async {
//     appPrint('url ${ApiCredential.baseUrl + url}');
//     try {
//       final response = await _baseClient.client.get(url);
//       return _returnResponse(response);
//     } on DioException catch (e) {
//       if (e.response != null) {
//         return _returnResponse(e.response!);
//       }
//     } on SocketException {
//       appPrint('No Internet');
//       throw FetchDataException('No Internet connection');
//     }
//   }
//
//   Future<dynamic> postRequest(String url, dynamic body) async {
//     appPrint('url ${ApiCredential.baseUrl + url}');
//     try {
//       final response = await _baseClient.client.post(
//         url,
//         data: jsonEncode(body),
//       );
//       return _returnResponse(response);
//     } on DioException catch (e) {
//       if (e.response != null) {
//         return _returnResponse(e.response!);
//       }
//     } on SocketException {
//       appPrint('No Internet');
//       throw FetchDataException('No Internet connection');
//     }
//   }
//   dynamic _returnResponse(Response<dynamic> response) {
//   appPrint("------------------------------");
//   appPrint("Status Code ${response.statusCode}");
//   appPrint("------------------------------");
//   switch (response.statusCode) {
//     case 200:
//       var responseJson = jsonEncode(response.data);
//       return responseJson;
//     case 201:
//       var responseJson = jsonEncode(response.data);
//       return responseJson;
//     case 204:
//       var responseJson = {'status_code': 204};
//       return responseJson;
//     case 400:
//       var responseJson = jsonEncode(response.data);
//       return responseJson;
//     case 401:
//       var responseJson = jsonEncode(response.data);
//       return responseJson;
//     case 403:
//       throw UnauthorisedException(response.data);
//     case 404:
//       var responseJson = jsonEncode(response.data);
//       return responseJson;
//     case 422:
//       throw ValidationException(response.data);
//     case 500:
//     default:
//       throw FetchDataException(
//           'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
//     }
//   }
// }
