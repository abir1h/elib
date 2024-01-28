import '../../../book/domain/entities/book_data_entity.dart';

class NoteDataEntity {
  final int? id;
  final int bookId;
  final int emisUserId;
  final String note;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final BookDataEntity? book;

  const NoteDataEntity({
    this.id,
    required this.bookId,
    required this.emisUserId,
    required this.note,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.book,
  });
}
