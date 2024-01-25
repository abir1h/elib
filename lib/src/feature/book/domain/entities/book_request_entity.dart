class BookRequestDataEntity {
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

  BookRequestDataEntity({
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
  });}