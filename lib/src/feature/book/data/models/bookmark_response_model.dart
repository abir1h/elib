
import 'dart:convert';

class BookmarkResponseModel {
  final int emisUserId;
  final int bookId;
  final String updatedAt;
  final String createdAt;
  final int id;

  BookmarkResponseModel({
    required this.emisUserId,
    required this.bookId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory BookmarkResponseModel.fromJson(Map<String, dynamic> json) => BookmarkResponseModel(
    emisUserId: json["emis_user_id"]??-1,
    bookId: json["book_id"]??-1,
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "emis_user_id": emisUserId,
    "book_id": bookId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
