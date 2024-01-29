import '../repositories/book_mark_repository.dart';
import '../../../shared/domain/entities/response_entity.dart';

class BookmarkUseCase {
  final BookmarkRepository _bookmarkRepository;
  BookmarkUseCase({required BookmarkRepository bookmarkRepository})
      : _bookmarkRepository = bookmarkRepository;

  Future<ResponseEntity> bookmarkUseCase(int bookId, int eMISUserId) async {
    final response = _bookmarkRepository.bookmarkBook(bookId, eMISUserId);
    return response;
  }

  Future<ResponseEntity> getBookmarkListUseCase() async {
    final response = _bookmarkRepository.getBookmarkBookList();
    return response;
  }
}
