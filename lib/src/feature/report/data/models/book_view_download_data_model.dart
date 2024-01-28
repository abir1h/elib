import '../../../book/data/models/book_data_model.dart';

class BookViewDownloadDataModel {
  final int id;
  final int bookId;
  final int userId;
  final int viewCount;
  final String createdAt;
  final String updatedAt;
  final int bookDownload;
  final BookDataModel? book;

  BookViewDownloadDataModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
    required this.bookDownload,
    this.book,
  });

  factory BookViewDownloadDataModel.fromJson(Map<String, dynamic> json) =>
      BookViewDownloadDataModel(
        id: json["id"] ?? -1,
        bookId: json["book_id"] ?? -1,
        userId: json["user_id"] ?? -1,
        viewCount: json["view_count"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        bookDownload: json["book_download"] ?? -1,
        book:
            json['book'] != null ? BookDataModel.fromJson(json['book']) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "user_id": userId,
        "view_count": viewCount,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "book_download": bookDownload,
        "book": book?.toJson(),
      };
  static List<BookViewDownloadDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, BookViewDownloadDataModel>(
            json.map((x) => BookViewDownloadDataModel.fromJson(x)).toList())
        : [];
  }
}
