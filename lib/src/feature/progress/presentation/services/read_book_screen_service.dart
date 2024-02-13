import 'package:flutter/material.dart';

import '../../../book/domain/entities/book_data_entity.dart';
import '../../../bookmark/data/data_sources/remote/bookmark_data_source.dart';
import '../../../bookmark/data/repositories/bookmark_repository_imp.dart';
import '../../../bookmark/domain/use_cases/book_mark_use_case.dart';
import '../../../progress/data/data_sources/remote/progress_data_source.dart';
import '../../../progress/data/repositories/progress_repository_imp.dart';
import '../../../progress/domain/use_cases/progress_use_case.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../report/domain/entities/book_report_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToBookDetailsScreen(BookDataEntity data);
}

mixin ReadBooksScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final ProgressUseCase _progressUseCase = ProgressUseCase(
      progressRepository: ProgressRepositoryImp(
          progressRemoteDataSource: ProgressRemoteDataSourceImp()));

  Future<ResponseEntity> getUserReadBooks() async {
    return _progressUseCase.getUserReadBooksUseCase();
  }

  final BookmarkUseCase _bookmarkUseCase = BookmarkUseCase(
      bookmarkRepository: BookmarkRepositoryImp(
          bookmarkRemoteDataSource: BookmarkRemoteDataSourceImp()));

  Future<ResponseEntity> bookmarkBookAction(
      {required int bookId, required int eMISUserId}) async {
    return _bookmarkUseCase.bookmarkUseCase(bookId, eMISUserId);
  }

  List<BookReportDataEntity> _bookList = [];

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadReadBookData();
  }

  @override
  void dispose() {
    readBookDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<BookReportDataEntity>>
      readBookDataStreamController = AppStreamController();

  ///Load Book Report data
  void _loadReadBookData() {
    if (!mounted) return;
    readBookDataStreamController.add(LoadingState());
    getUserReadBooks().then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        _bookList = value.data as List<BookReportDataEntity>;
        var dataList =
            _bookList.where((element) => (element.book != null)).toList();

        readBookDataStreamController
            .add(DataLoadedState<List<BookReportDataEntity>>(dataList));
      } else if (value.error == null && value.data.isEmpty) {
        readBookDataStreamController.add(EmptyState(message: 'No Book Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onBookContentSelected(BookDataEntity item) {
    _view.navigateToBookDetailsScreen(item);
  }

  void onBookmarkSelected(BookDataEntity item) {
    bookmarkBookAction(
      bookId: item.id,
      eMISUserId: 1,
    ).then((value) {
      if (value.error == null && value.data != null) {
        int index = _bookList.indexWhere((element) => element.id == item.id);
        _bookList[index].book!.bookMark = !_bookList[index].book!.bookMark;
        readBookDataStreamController
            .add(DataLoadedState<List<BookReportDataEntity>>(_bookList));
        _view.showSuccess(item.bookMark
            ? "বুকমার্ক সফলভাবে যোগ করা হয়েছে !"
            : "বুকমার্ক সফলভাবে মুছে ফেলা হয়েছে !");
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
