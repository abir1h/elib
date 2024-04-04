import 'package:flutter/cupertino.dart';

import '../../../author/data/models/author_data_model.dart';
import '../../../category/data/models/category_data_model.dart';
import 'book_data_model.dart';

@immutable
class BookDetailsDataModel {
  final BookDataModel? bookDetails;
  final List<AuthorDataModel> authorBook;
  final List<CategoryDataModel> categoryBook;

  const BookDetailsDataModel({
    required this.bookDetails,
    required this.authorBook,
    required this.categoryBook,
  });

  factory BookDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      BookDetailsDataModel(
        bookDetails: json["book_details"] != null
            ? BookDataModel.fromJson(json["book_details"])
            : null,
        authorBook: json["author_book"] != null
            ? List<AuthorDataModel>.from(
                (json["author_book"]).map((x) => AuthorDataModel.fromJson(x)))
            : [],
        categoryBook: json['category_book'] != null
            ? List<CategoryDataModel>.from((json["category_book"])
                .map((x) => CategoryDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "book_details": bookDetails?.toJson(),
        "author_book": List<dynamic>.from(authorBook.map((x) => x.toJson())),
        "category_book":
            List<dynamic>.from(categoryBook.map((x) => x.toJson())),
      };
}
