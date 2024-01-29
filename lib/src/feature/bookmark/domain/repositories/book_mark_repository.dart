import '../../../shared/domain/entities/response_entity.dart';

abstract class BookmarkRepository {
  Future<ResponseEntity> bookmarkBook(int bookId, int eMISUserId);
  Future<ResponseEntity> getBookmarkBookList();
}
