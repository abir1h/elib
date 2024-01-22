import 'book_data_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class BookmarkDataModel {
  final int id;
  final int bookId;
  final int emisUserId;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final int status;
  final BookDataModel? book;

  const BookmarkDataModel({
    required this.id,
    required this.bookId,
    required this.emisUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.status,
    required this.book,
  });
  factory BookmarkDataModel.fromJson(Map<String, dynamic> json) =>
      BookmarkDataModel(
        id: json["id"] ?? -1,
        bookId: json["book_id"] ?? -1,
        emisUserId: json["emis_user_id"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        status: json["status"] ?? -1,
        book:
            json['book'] != null ? BookDataModel.fromJson(json['book']) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "emis_user_id": emisUserId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "status": status,
        "book": book?.toJson(),
      };
  static List<BookmarkDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, BookmarkDataModel>(
            json.map((x) => BookmarkDataModel.fromJson(x)).toList())
        : [];
  }
}
