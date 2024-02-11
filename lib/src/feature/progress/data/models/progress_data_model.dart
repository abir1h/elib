import 'package:flutter/cupertino.dart';

@immutable
class ProgressDataModel {
  final int bookRequests;
  final int bookViews;

  const ProgressDataModel({
    required this.bookRequests,
    required this.bookViews,
  });

  factory ProgressDataModel.fromJson(Map<String, dynamic> json) =>
      ProgressDataModel(
        bookRequests: json["book_requests"] ?? -1,
        bookViews: json["book_views"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "book_requests": bookRequests,
        "book_views": bookViews,
      };
}
