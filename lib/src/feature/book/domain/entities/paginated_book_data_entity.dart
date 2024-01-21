import 'package:flutter/cupertino.dart';

import '../../../category/domain/entities/category_link_data_enitity.dart';
import 'book_data_entity.dart';

@immutable
class PaginatedBookDataEntity {
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

  const PaginatedBookDataEntity(
      {required this.currentPage,
      required this.firstPageUrl,
      required this.from,
      required this.lastPage,
      required this.lastPageUrl,
      required this.nextPageUrl,
      required this.path,
      required this.perPage,
      required this.prevPageUrl,
      required this.to,
      required this.total,
      required this.links,
      required this.bookDataEntity});
}
