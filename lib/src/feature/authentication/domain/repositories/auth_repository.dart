import '../../../shared/domain/entities/response_entity.dart';

abstract class AuthRepository {
  Future<ResponseEntity> getToken(String username, String eMISToken);
  Future<ResponseEntity> getEMISLink();
}
