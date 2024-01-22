import 'package:flutter/cupertino.dart';

@immutable
class CountUserResponseModel {
  final int id;
  final int bookId;
  final int userId;
  final int viewCount;
  final String createdAt;
  final String updatedAt;

  const CountUserResponseModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CountUserResponseModel.fromJson(Map<String, dynamic> json) =>
      CountUserResponseModel(
        id: json["id"] ?? -1,
        bookId: json["book_id"] ?? -1,
        userId: json["user_id"] ?? -1,
        viewCount: json["view_count"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "user_id": userId,
        "view_count": viewCount,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
