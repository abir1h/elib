class CountUserResponseEntity {
  final int id;
  final int bookId;
  final int userId;
  final int viewCount;
  final String createdAt;
  final String updatedAt;

  CountUserResponseEntity({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
  });
}
