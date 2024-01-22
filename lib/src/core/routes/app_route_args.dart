

class BookDetailsScreenArgs {
  final int bookId;
  BookDetailsScreenArgs( {required this.bookId,});
}

class BookViewerScreenArgs{
  String url;
  String title;
  final bool canDownload;
  final int timeToReadInSeconds;
  final void Function(String docId,int readTimeInSec,)? onReadingEnded;
  BookViewerScreenArgs({required this.url, this.onReadingEnded, this.canDownload = false, this.title="", this.timeToReadInSeconds = -1});
}