import 'package:flutter/cupertino.dart';

import '../../../report/data/models/book_report_data_model.dart';
import '../../../author/data/models/author_data_model.dart';
import '../../../book/data/models/book_data_model.dart';
import '../../../category/data/models/category_data_model.dart';

@immutable
class HomeDataModel {
  final List<BookDataModel> latestBook;
  final List<BookReportDataModel> mostViewedBooks;
  final List<CategoryDataModel> categories;
  final List<CategoryDataModel> categoriesTwo;
  final List<AuthorDataModel> authors;

  const HomeDataModel(
      {required this.latestBook,
      required this.mostViewedBooks,
      required this.categories,
      required this.categoriesTwo,
      required this.authors});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        latestBook: json["latestBooks"] != null
            ? List<BookDataModel>.from(
                (json["latestBooks"]).map((x) => BookDataModel.fromJson(x)))
            : [],
        mostViewedBooks: json["mostViewedBooks"] != null
            ? List<BookReportDataModel>.from((json["mostViewedBooks"])
                .map((x) => BookReportDataModel.fromJson(x)))
            : [],
        categories: json["categories"] != null
            ? List<CategoryDataModel>.from(
                (json["categories"]).map((x) => CategoryDataModel.fromJson(x)))
            : [],
        categoriesTwo: json["categories2"] != null
            ? List<CategoryDataModel>.from(
                (json["categories2"]).map((x) => CategoryDataModel.fromJson(x)))
            : [],
        authors: json["authors"] != null
            ? List<AuthorDataModel>.from(
                (json["authors"]).map((x) => AuthorDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "latestBooks": List<dynamic>.from(latestBook.map((x) => x.toJson())),
        "mostViewedBooks":
            List<dynamic>.from(mostViewedBooks.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "categories2": List<dynamic>.from(categoriesTwo.map((x) => x.toJson())),
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
      };

  static List<HomeDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, HomeDataModel>(
            json.map((x) => HomeDataModel.fromJson(x)).toList())
        : [];
  }
}
