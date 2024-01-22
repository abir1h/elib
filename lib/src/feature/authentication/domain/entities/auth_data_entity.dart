class AuthDataEntity {
  final String url;
  final String accessToken;
  final String expiresAt;
  final String refreshToken;
  final String role;
  final List<String> permissions;

  AuthDataEntity(
      {required this.url,
      required this.accessToken,
      required this.expiresAt,
      required this.refreshToken,
      required this.role,
      required this.permissions});
}
