import '../../../book/data/models/book_data_model.dart';

class BookReportDataModel {
  final int id;
  final int bookId;
  final int userId;
  final int viewCount;
  final String createdAt;
  final String updatedAt;
  final int bookDownload;
  final BookDataModel? book;

  BookReportDataModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
    required this.bookDownload,
    this.book,
  });

  factory BookReportDataModel.fromJson(Map<String, dynamic> json) =>
      BookReportDataModel(
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
  static List<BookReportDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, BookReportDataModel>(
            json.map((x) => BookReportDataModel.fromJson(x)).toList())
        : [];
  }
}
