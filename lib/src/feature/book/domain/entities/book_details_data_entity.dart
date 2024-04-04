import '../../../author/domain/entities/author_data_entity.dart';
import '../../../category/domain/entities/category_data_entity.dart';
import 'book_data_entity.dart';

class BookDetailsDataEntity {
  final BookDataEntity bookDetails;
  final List<AuthorDataEntity>? authorBook;
  final List<CategoryDataEntity>? categoryBook;

  BookDetailsDataEntity({
    required this.bookDetails,
    required this.authorBook,
    required this.categoryBook,
  });
}
