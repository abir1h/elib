import '../../feature/report/domain/entities/book_report_data_entity.dart';
import '../../feature/book/domain/entities/tag_data_entity.dart';
import '../../feature/author/domain/entities/author_data_entity.dart';
import '../../feature/note/domain/entities/note_data_entity.dart';
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
  int bookId;
  String url;
  String title;
  final bool canDownload;
  final int timeToReadInSeconds;
  final void Function(
    String docId,
    int readTimeInSec,
  )? onReadingEnded;
  BookViewerScreenArgs(
      {required this.bookId,
      required this.url,
      this.onReadingEnded,
      this.canDownload = false,
      this.title = "",
      this.timeToReadInSeconds = -1});
}

class ExternalBookViewScreenArgs {
  final String url;
  String title;
  ExternalBookViewScreenArgs({
    required this.url,
    this.title = "",
  });
}

class CategoryDetailsScreenArgs {
  final String categoryNameEn;
  final String categoryNameBn;
  final int categoryId;
  CategoryDetailsScreenArgs({
    required this.categoryNameEn,
    required this.categoryNameBn,
    required this.categoryId,
  });
}

class BookReportListScreenArgs {
  final String startDate;
  final String endDate;
  BookReportListScreenArgs({
    required this.startDate,
    required this.endDate,
  });
}

class NoteDetailsScreenArgs {
  final NoteDataEntity noteDataEntity;
  NoteDetailsScreenArgs({required this.noteDataEntity});
}

class AuthorBookScreenArgs {
  final AuthorDataEntity authorDataEntity;
  AuthorBookScreenArgs({required this.authorDataEntity});
}

class TagBookScreenArgs {
  final TagDataEntity tagDataEntity;
  TagBookScreenArgs({required this.tagDataEntity});
}

class LatestBookScreenArgs {
  final List<BookDataEntity> items;
  LatestBookScreenArgs({required this.items});
}

class MostViewedBookScreenArgs {
  final List<BookReportDataEntity> items;
  MostViewedBookScreenArgs({required this.items});
}
