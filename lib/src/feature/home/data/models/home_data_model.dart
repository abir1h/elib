import 'package:flutter/cupertino.dart';

import '../../../author/data/models/author_data_model.dart';
import '../../../book/data/models/book_data_model.dart';
import '../../../category/data/models/category_data_model.dart';

@immutable
class HomeDataModel {
  final List<BookDataModel> latestBook;
  final List<CategoryDataModel> categoriesOne;
  final List<CategoryDataModel> categoriesTwo;
  final List<AuthorDataModel> authors;

  const HomeDataModel(
      {required this.latestBook,
      required this.categoriesOne,
      required this.categoriesTwo,
      required this.authors});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        latestBook: json["latestBook"] != null
            ? List<BookDataModel>.from(
                (json["latestBook"]).map((x) => BookDataModel.fromJson(x)))
            : [],
        categoriesOne: json["categories1"] != null
            ? List<CategoryDataModel>.from(
                (json["categories1"]).map((x) => CategoryDataModel.fromJson(x)))
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
        "latestBook": List<dynamic>.from(latestBook.map((x) => x.toJson())),
        "categories1": List<dynamic>.from(categoriesOne.map((x) => x.toJson())),
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
