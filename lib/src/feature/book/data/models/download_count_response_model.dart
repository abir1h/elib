import 'package:flutter/foundation.dart';

@immutable
class DownloadCountResponseModel {
  final int id;
  final int bookId;
  final int userId;
  final int downloadCount;
  final String createdAt;
  final String updatedAt;

  const DownloadCountResponseModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.downloadCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DownloadCountResponseModel.fromJson(Map<String, dynamic> json) => DownloadCountResponseModel(
    id: json["id"]??-1,
    bookId: json["book_id"]??-1,
    userId: json["user_id"]??-1,
    downloadCount: json["download_count"]??-1,
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "book_id": bookId,
    "user_id": userId,
    "download_count": downloadCount,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}