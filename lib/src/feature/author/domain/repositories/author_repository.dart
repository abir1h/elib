import '../../../shared/domain/entities/response_entity.dart';

abstract class AuthorRepository {
  Future<ResponseEntity> getAuthors();
}
