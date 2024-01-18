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
}
