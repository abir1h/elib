import '../../../author/domain/entities/author_data_entity.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../category/domain/entities/category_data_entity.dart';

class HomeDataEntity {
  final List<BookDataEntity> latestBook;
  final List<CategoryDataEntity> categoriesOne;
  final List<CategoryDataEntity> categoriesTwo;
  final List<AuthorDataEntity> authors;

  HomeDataEntity(
      {required this.latestBook,
      required this.categoriesOne,
      required this.categoriesTwo,
      required this.authors});
}