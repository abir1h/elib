import '../entities/book_request_entity.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class BookRepository {
  Future<ResponseEntity> getBooks();
  Future<ResponseEntity> getPopularBooks(int pageNumber);
  Future<ResponseEntity> getBookDetails(int bookId);

  Future<ResponseEntity> userBookViewCountAction(int bookId);
  Future<ResponseEntity> userBookDownloadCountAction(int bookId);

  Future<ResponseEntity> globalSearch(String searchQuery, String type);

  Future<ResponseEntity> getBookRequests(bool enablePagination,
      {int? pageNumber});
  Future<ResponseEntity> createBookRequest(
      BookRequestDataEntity bookRequestDataEntity);
  Future<ResponseEntity> updateBookRequest(
      BookRequestDataEntity bookRequestDataEntity);
  Future<ResponseEntity> deleteBookRequest(int bookRequestId);
  Future<ResponseEntity> getBookRequestDetails(int bookRequestId);
}
