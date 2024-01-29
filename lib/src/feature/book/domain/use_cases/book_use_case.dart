import '../entities/book_request_entity.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/book_repository.dart';

class BookUseCase {
  final BookRepository _bookRepository;
  BookUseCase({required BookRepository bookRepository})
      : _bookRepository = bookRepository;

  Future<ResponseEntity> getBooksUseCase() async {
    final response = _bookRepository.getBooks();
    return response;
  }

  Future<ResponseEntity> getPopularBooksUseCase(int pageNumber) async {
    final response = _bookRepository.getPopularBooks(pageNumber);
    return response;
  }

  Future<ResponseEntity> getBookDetailsUseCase(int bookId) async {
    final response = _bookRepository.getBookDetails(bookId);
    return response;
  }

  Future<ResponseEntity> userBookViewCountActionUseCase(int bookId) async {
    final response = _bookRepository.userBookViewCountAction(bookId);
    return response;
  }

  Future<ResponseEntity> userBookDownloadCountActionUseCase(int bookId) async {
    final response = _bookRepository.userBookDownloadCountAction(bookId);
    return response;
  }

  Future<ResponseEntity> globalSearchUseCase(String searchQuery) async {
    final response = _bookRepository.globalSearch(searchQuery);
    return response;
  }

  Future<ResponseEntity> getBookRequestsUseCase(bool enablePagination,
      {int? pageNumber}) async {
    final response = _bookRepository.getBookRequests(enablePagination,
        pageNumber: pageNumber);
    return response;
  }

  Future<ResponseEntity> createBookRequestUseCase(
      BookRequestDataEntity bookRequestDataEntity) async {
    final response = _bookRepository.createBookRequest(bookRequestDataEntity);
    return response;
  }

  Future<ResponseEntity> updateBookRequestUseCase(
      BookRequestDataEntity bookRequestDataEntity) async {
    final response = _bookRepository.updateBookRequest(bookRequestDataEntity);
    return response;
  }

  Future<ResponseEntity> deleteBookRequestUseCase(int bookRequestId) async {
    final response = _bookRepository.deleteBookRequest(bookRequestId);
    return response;
  }

  Future<ResponseEntity> getBookRequestDetailsUseCase(int bookRequestId) async {
    final response = _bookRepository.getBookRequestDetails(bookRequestId);
    return response;
  }
}
