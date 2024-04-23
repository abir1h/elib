class BookmarkResponseEntity {
  final int emisUserId;
  final int bookId;
  final String updatedAt;
  final String createdAt;
  final int id;
  final bool status;

  BookmarkResponseEntity(
      {required this.emisUserId,
      required this.bookId,
      required this.updatedAt,
      required this.createdAt,
      required this.id,
      required this.status});
}
