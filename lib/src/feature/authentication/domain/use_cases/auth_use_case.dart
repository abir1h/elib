import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<ResponseEntity> getTokenUseCase(String username, String eMISToken) async {
    final response = _authRepository.getToken(username, eMISToken);
    return response;
  }

  Future<ResponseEntity> getEMISLinkUseCase() async {
    final response = _authRepository.getEMISLink();
    return response;
  }
}
