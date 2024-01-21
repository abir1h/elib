import 'package:flutter/cupertino.dart';

@immutable
class PivotDataModel {
  final int bookId;
  final int categoryId;

  const PivotDataModel({
    required this.bookId,
    required this.categoryId,
  });

  factory PivotDataModel.fromJson(Map<String, dynamic> json) => PivotDataModel(
        bookId: json["book_id"] ?? -1,
        categoryId: json["category_id"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "category_id": categoryId,
      };
}
