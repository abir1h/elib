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
  Future<ResponseEntity> getPopularBooksUseCase() async {
    final response = _bookRepository.getPopularBooks();
    return response;
  }
  Future<ResponseEntity> getBookDetailsUseCase(int bookId) async {
    final response = _bookRepository.getBookDetails(bookId);
    return response;
  }
  Future<ResponseEntity> saveBookUseCase(int bookId, int status) async {
    final response = _bookRepository.saveBook(bookId, status);
    return response;
  }
}
