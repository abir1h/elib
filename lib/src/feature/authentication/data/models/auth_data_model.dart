import 'package:flutter/foundation.dart';

@immutable
class AuthDataModel {
  final String url;
  final String accessToken;
  final String expiresAt;
  final String refreshToken;
  final String role;
  final List<String> permissions;

  const AuthDataModel(
      {required this.url,
      required this.accessToken,
      required this.expiresAt,
      required this.refreshToken,
      required this.role,
      required this.permissions});

  factory AuthDataModel.fromJson(Map<String, dynamic> json) => AuthDataModel(
      url: json["url"] ?? "",
      accessToken: json["access_token"] ?? "",
      expiresAt: json["expires_at"] ?? "",
      refreshToken: json["refresh_token"] ?? "",
      role: json["role"] ?? "",
      permissions: json['permissions'] == null
          ? []
          : List<String>.from(json["permissions"].map((x) => x)));

  Map<String, dynamic> toJson() => {
        "url": url,
        "access_token": accessToken,
        "expires_at": expiresAt,
        "refresh_token": refreshToken,
        "role": role,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
      };
}
