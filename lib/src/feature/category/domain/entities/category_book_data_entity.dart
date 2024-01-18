import 'book_link_data_enitity.dart';
import 'category_data_entity.dart';

class CategoryBookDataEntity {
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
  final List<BookLinkDataEntity> links;
  final List<CategoryDataEntity> categoryDataModel;

  CategoryBookDataEntity({
    required this.currentPage,
    required this.categoryDataModel,
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
  });
}
