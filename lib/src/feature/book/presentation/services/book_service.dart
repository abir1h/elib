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

  Future<ResponseEntity> bookmarkBook(int bookId, int eMISUserId, int status) async {
    return _bookUseCase.bookmarkUseCase(bookId, eMISUserId, status);
  }
  Future<ResponseEntity> getBookmarkBookList() async {
    return _bookUseCase.getBookmarkListUseCase();
  }
}
