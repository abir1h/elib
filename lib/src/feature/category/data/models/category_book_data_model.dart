import 'package:flutter/foundation.dart';

import 'book_link_data_model.dart';
import 'category_data_model.dart';

@immutable
class CategoryBookDataModel {
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
  final List<BookLinkDataModel> links;
  final List<CategoryDataModel> categoryDataModel;

  const CategoryBookDataModel({
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

  factory CategoryBookDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryBookDataModel(
        currentPage: json["current_page"] ?? -1,
        firstPageUrl: json["first_page_url"] ?? "",
        from: json["from"] ?? -1,
        lastPage: json["last_page"] ?? -1,
        lastPageUrl: json["last_page_url"] ?? "",
        nextPageUrl: json["next_page_url"] ?? "",
        path: json["path"] ?? "",
        perPage: json["per_page"] ?? -1,
        prevPageUrl: json["prev_page_url"] ?? "",
        to: json["to"] ?? -1,
        total: json["total"] ?? -1,
        links: List<BookLinkDataModel>.from(
            (json["links"] ?? []).map((x) => BookLinkDataModel.fromJson(x))),
        categoryDataModel: List<CategoryDataModel>.from(
            (json["data"] ?? []).map((x) => CategoryDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(categoryDataModel.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}
