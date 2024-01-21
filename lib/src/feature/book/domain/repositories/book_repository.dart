import '../../../shared/domain/entities/response_entity.dart';

abstract class BookRepository {
  Future<ResponseEntity> getBooks();
  Future<ResponseEntity> getBookDetails(int bookId);
  Future<ResponseEntity> saveBook(int bookId, int status);
}