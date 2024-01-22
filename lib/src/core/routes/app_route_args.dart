import '../../feature/book/domain/entities/book_data_entity.dart';

class BookDetailsScreenArgs {
  final int bookId;
  BookDetailsScreenArgs({
    required this.bookId,
  });
}

class CategoryDetailsScreenArgs {
  final String categoryName;
  final List<BookDataEntity> books;
  CategoryDetailsScreenArgs({
    required this.categoryName,
    required this.books,
  });
}
