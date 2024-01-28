import 'package:elibrary/src/feature/book/domain/entities/book_data_entity.dart';

import '../../data/models/book_data_model.dart';

class BookViewDownloadDataEntity {
  final int id;
  final int bookId;
  final int userId;
  final int viewCount;
  final String createdAt;
  final String updatedAt;
  final int bookDownload;
  final BookDataEntity? book;

  BookViewDownloadDataEntity({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
    required this.bookDownload,
    this.book,
  });
}
