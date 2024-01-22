class BookmarkResponseEntity {
  final int emisUserId;
  final int bookId;
  final String updatedAt;
  final String createdAt;
  final int id;

  BookmarkResponseEntity({
    required this.emisUserId,
    required this.bookId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });
}
