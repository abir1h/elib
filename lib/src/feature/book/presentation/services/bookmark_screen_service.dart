import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/book_data_source.dart';
import '../../data/repositories/book_repository_imp.dart';
import '../../domain/entities/book_data_entity.dart';
import '../../domain/entities/bookmark_data_entity.dart';
import '../../domain/use_cases/book_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
/*  void showWarning(String message);
  void navigateToCategoryDetailsScreen(
      String categoryName, List<BookDataEntity> data);
  void navigateToBookDetailsScreen(BookDataEntity data);*/
}

mixin BookmarkScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
          BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> bookmarkBookAction(
      int bookId, int eMISUserId, int status) async {
    return _bookUseCase.bookmarkUseCase(bookId, eMISUserId, status);
  }

  Future<ResponseEntity> getBookmarkBookList() async {
    return _bookUseCase.getBookmarkListUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadBookmarkListData();
  }

  @override
  void dispose() {
    bookmarkDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<BookmarkDataEntity>>
      bookmarkDataStreamController = AppStreamController();

  ///Load Category list
  void _loadBookmarkListData() {
    if (!mounted) return;
    bookmarkDataStreamController.add(LoadingState());
    getBookmarkBookList().then((value) {
      if (value.error == null && value.data != null) {
        if (value.data is List<BookmarkDataEntity>) {
          // Check if value.data is a List<BookmarkDataEntity>
          bookmarkDataStreamController.add(
            DataLoadedState<List<BookmarkDataEntity>>(
              value.data as List<BookmarkDataEntity>,
            ),
          );
        } else {
          // Handle the case where value.data is not a List<BookmarkDataEntity>
          _view.showWarning("Invalid data format");
        }
      } else if (value.error == null &&
          (value.data == null || value.data.isEmpty)) {
        // Handle the case where there is no data
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
