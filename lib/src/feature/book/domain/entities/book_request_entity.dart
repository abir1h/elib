class BookRequestDataEntity {
  final int? id;
  final int emisUserId;
  final String authorName;
  final String bookName;
  final String publishYear;
  final String edition;
  final String remark;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  BookRequestDataEntity({
    this.id,
    required this.emisUserId,
    required this.authorName,
    required this.bookName,
    required this.publishYear,
    required this.edition,
    required this.remark,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
}
