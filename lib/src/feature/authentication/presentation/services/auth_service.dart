import '../../../../core/service/auth_cache_manager.dart';
import '../../data/data_sources/remote/auth_data_source.dart';
import '../../data/repositories/auth_repository_imp.dart';
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
    storeUserInfo(responseEntity);
    // UserService.setCurrentSession(responseEntity.data);
    return responseEntity;
  }

  static Future<ResponseEntity> getEMISLink() async {
    return _authUseCase.getEMISLinkUseCase();
  }

  static storeUserInfo(ResponseEntity responseEntity) async {
    if (responseEntity.data != null) {
      if (responseEntity.data?.accessToken != null &&
          responseEntity.data?.refreshToken != null &&
          responseEntity.data?.expiresAt != null) {
        AuthCacheManager.storeUserInfo(responseEntity.data?.accessToken,
            responseEntity.data?.refreshToken, responseEntity.data?.expiresAt);
      }
    }
  }
}
