import '../../domain/entities/book_request_entity.dart';
import '../../data/data_sources/remote/book_data_source.dart';
import '../../data/repositories/book_repository_imp.dart';
import '../../domain/use_cases/book_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

mixin class BookService {
  BookService._();
  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
          BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> getBooks() async {
    return _bookUseCase.getBooksUseCase();
  }

  Future<ResponseEntity> getPopularBooks(int pageNumber) async {
    return _bookUseCase.getPopularBooksUseCase(pageNumber);
  }

  Future<ResponseEntity> getBookDetails(int bookId) async {
    return _bookUseCase.getBookDetailsUseCase(bookId);
  }

  Future<ResponseEntity> userBookViewCountAction(int bookId) async {
    return _bookUseCase.userBookViewCountActionUseCase(bookId);
  }

  Future<ResponseEntity> userBookDownloadCountAction(int bookId) async {
    return _bookUseCase.userBookDownloadCountActionUseCase(bookId);
  }

  Future<ResponseEntity> globalSearch(String searchQuery, String type) async {
    return _bookUseCase.globalSearchUseCase(searchQuery, type);
  }

  Future<ResponseEntity> getBookRequests(bool enablePagination,
      {int? pageNumber}) async {
    return _bookUseCase.getBookRequestsUseCase(enablePagination,
        pageNumber: pageNumber);
  }

  Future<ResponseEntity> createBookRequest(
      BookRequestDataEntity bookRequestDataEntity) async {
    return _bookUseCase.createBookRequestUseCase(bookRequestDataEntity);
  }

  Future<ResponseEntity> updateBookRequest(
      BookRequestDataEntity bookRequestDataEntity) async {
    return _bookUseCase.updateBookRequestUseCase(bookRequestDataEntity);
  }

  Future<ResponseEntity> deleteBookRequest(int bookRequestId) async {
    return _bookUseCase.deleteBookRequestUseCase(bookRequestId);
  }

  Future<ResponseEntity> getBookRequestDetails(int bookRequestId) async {
    return _bookUseCase.getBookRequestDetailsUseCase(bookRequestId);
  }
}
