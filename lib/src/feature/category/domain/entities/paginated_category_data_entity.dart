import '../../../book/domain/entities/book_data_entity.dart';
import 'category_link_data_enitity.dart';
import 'category_data_entity.dart';

class PaginatedCategoryDataEntity {
  final int currentPage;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;
  final List<CategoryLinkDataEntity> links;
  final List<BookDataEntity> bookDataEntity;
  final List<CategoryDataEntity> categoryDataEntity;

  PaginatedCategoryDataEntity({
    required this.currentPage,
    required this.categoryDataEntity,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.bookDataEntity
  });
}
