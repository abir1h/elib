import '../../../shared/domain/entities/response_entity.dart';

abstract class BookRepository {
  Future<ResponseEntity> getBooks();
}