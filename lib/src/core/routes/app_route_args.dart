import '../../feature/book/domain/entities/book_data_entity.dart';

class EMISWebViewScreenArgs {
  final String webViewLink;
  EMISWebViewScreenArgs({required this.webViewLink});
}

class BookDetailsScreenArgs {
  final BookDataEntity bookData;
  BookDetailsScreenArgs({
    required this.bookData,
  });
}

class BookViewerScreenArgs {
  String url;
  String title;
  final bool canDownload;
  final int timeToReadInSeconds;
  final void Function(
    String docId,
    int readTimeInSec,
  )? onReadingEnded;
  BookViewerScreenArgs(
      {required this.url,
      this.onReadingEnded,
      this.canDownload = false,
      this.title = "",
      this.timeToReadInSeconds = -1});
}

class CategoryDetailsScreenArgs {
  final String categoryName;
  final int  categoryId;
  CategoryDetailsScreenArgs({
    required this.categoryName,
    required this.categoryId,
  });
}
