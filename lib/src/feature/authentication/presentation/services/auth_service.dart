import 'package:elibrary/src/feature/authentication/data/data_sources/remote/auth_data_source.dart';
import 'package:elibrary/src/feature/authentication/data/repositories/auth_repository_imp.dart';

import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/use_cases/auth_use_case.dart';

class AuthService {
  AuthService._();

  static final AuthUseCase _authUseCase = AuthUseCase(
      authRepository:
          AuthRepositoryImp(authRemoteDataSource: AuthRemoteDataSourceImp()));

  static Future<ResponseEntity> getToken(
      String username, String eMISToken) async {
    ResponseEntity responseEntity =
        await _authUseCase.getTokenUseCase(username, eMISToken);
    // storeUserInfo(responseEntity);
    // UserService.setCurrentSession(responseEntity.data);
    return responseEntity;
  }

  static Future<ResponseEntity> getEMISLink() async {
    return _authUseCase.getEMISLinkUseCase();
  }

  // static storeUserInfo(ResponseEntity responseEntity) async {
  //   LocalStorageService localStorageService =
  //       await LocalStorageService.getInstance();
  //   if (responseEntity.data != null) {
  //     if (responseEntity.data?.accessToken != null) {
  //       localStorageService.storeStringValue(
  //           StringData.accessTokenKey, responseEntity.data!.accessToken);
  //     }
  //     if (responseEntity.data?.refreshToken != null) {
  //       localStorageService.storeStringValue(
  //           StringData.refreshTokenKey, responseEntity.data!.refreshToken);
  //     }
  //     if (responseEntity.data?.expiresAt != null) {
  //       localStorageService.storeStringValue(
  //           StringData.expiresAt, responseEntity.data!.expiresAt);
  //     }
  //   }
  // }
}
