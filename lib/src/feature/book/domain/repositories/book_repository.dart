import '../../../shared/domain/entities/response_entity.dart';

abstract class BookRepository {
  Future<ResponseEntity> getBooks();
  Future<ResponseEntity> getPopularBooks(int pageNumber);
  Future<ResponseEntity> getBookDetails(int bookId);
  Future<ResponseEntity> bookmarkBook(int bookId, int eMISUserId, int status);
  Future<ResponseEntity> getBookmarkBookList();
  Future<ResponseEntity> userBookViewCountAction(int bookId);
  Future<ResponseEntity> userBookDownloadCountAction(int bookId);
}