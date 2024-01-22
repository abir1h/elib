import 'book_data_entity.dart';


class BookmarkDataEntity {
  final int id;
  final int bookId;
  final int emisUserId;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final int status;
  final BookDataEntity? book;

  const BookmarkDataEntity({
    required this.id,
    required this.bookId,
    required this.emisUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.status,
    required this.book,
  });
}
