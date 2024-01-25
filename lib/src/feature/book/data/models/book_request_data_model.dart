
class BookRequestDataModel {
  final int id;
  final int emisUserId;
  final String authorName;
  final String bookName;
  final String publishYear;
  final String edition;
  final String remark;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  BookRequestDataModel({
    required this.id,
    required this.emisUserId,
    required this.authorName,
    required this.bookName,
    required this.publishYear,
    required this.edition,
    required this.remark,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory BookRequestDataModel.fromJson(Map<String, dynamic> json) => BookRequestDataModel(
    id: json["id"]??-1,
    emisUserId: json["emis_user_id"]??-1,
    authorName: json["author_name"]??"",
    bookName: json["book_name"]??"",
    publishYear: json["publish_year"]??"",
    edition: json["edition"]??"",
    remark: json["remark"]??"",
    status: json["status"]??-1,
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    deletedAt: json["deleted_at"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emis_user_id": emisUserId,
    "author_name": authorName,
    "book_name": bookName,
    "publish_year": publishYear,
    "edition": edition,
    "remark": remark,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}