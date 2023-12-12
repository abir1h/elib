import 'package:dio/dio.dart';

import '../constants/urls.dart';

class BaseHttpClient {
  final _client = Dio();

  static String get baseURL {
    return ApiCredential.baseUrl;
  }

  Dio get client {
    _client.options.baseUrl = baseURL;
    _client.options.headers = {
      'Accept': 'application/json',
    };
    return _client;
  }

  Dio get authenticatedClient {
    final httpClient = client;
    String token = ApiCredential.apiKey;
    httpClient.options.headers = {
      'Accept': 'application/json',
      'Authorization': token
    };
    return httpClient;
  }
}
