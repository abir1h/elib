import '../../../book/domain/entities/book_data_entity.dart';

class NoteDataEntity {
  final int id;
  final int bookId;
  final int emisUserId;
  final String note;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final BookDataEntity? book;

  const NoteDataEntity({
    required this.id,
    required this.bookId,
    required this.emisUserId,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.book,
  });
}
