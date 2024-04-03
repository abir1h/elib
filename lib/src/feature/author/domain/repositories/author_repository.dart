import '../../../shared/domain/entities/response_entity.dart';

abstract class AuthorRepository {
  Future<ResponseEntity> getAuthors(int currentPage);
  Future<ResponseEntity> getBookByAuthors(int authorId);
}
