class DownloadCountResponseEntity {
  final int id;
  final int bookId;
  final int userId;
  final int downloadCount;
  final String createdAt;
  final String updatedAt;

  DownloadCountResponseEntity({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.downloadCount,
    required this.createdAt,
    required this.updatedAt,
  });
}
