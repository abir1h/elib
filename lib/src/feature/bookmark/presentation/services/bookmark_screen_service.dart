import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../bookmark/domain/entities/bookmark_data_entity.dart';
import '../../data/data_sources/remote/bookmark_data_source.dart';
import '../../data/repositories/bookmark_repository_imp.dart';
import '../../domain/use_cases/book_mark_use_case.dart';
import '../../../book/domain/entities/tag_data_entity.dart';

abstract class _ViewModel {
  void showSuccess(String message);
  void showWarning(String message);
  void navigateToNotificationScreen();
  void navigateToBookDetailsScreen(BookmarkDataEntity data);
  void navigateToTagBookScreen(TagDataEntity data);

/*  void showWarning(String message);
  void navigateToCategoryDetailsScreen(
      String categoryName, List<BookDataEntity> data);
  void navigateToBookDetailsScreen(BookDataEntity data);*/
}

mixin BookmarkScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final BookmarkUseCase _bookmarkUseCase = BookmarkUseCase(
      bookmarkRepository: BookmarkRepositoryImp(
          bookmarkRemoteDataSource: BookmarkRemoteDataSourceImp()));

  Future<ResponseEntity> bookmarkBookAction(
      {required int bookId, required int eMISUserId}) async {
    return _bookmarkUseCase.bookmarkUseCase(bookId, eMISUserId);
  }

  Future<ResponseEntity> getBookmarkBookList() async {
    return _bookmarkUseCase.getBookmarkListUseCase();
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

  List<BookmarkDataEntity> _bookList = [];

  ///Load Category list
  void _loadBookmarkListData() {
    if (!mounted) return;
    bookmarkDataStreamController.add(LoadingState());
    getBookmarkBookList().then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        _bookList = value.data;
        bookmarkDataStreamController
            .add(DataLoadedState<List<BookmarkDataEntity>>(value.data!));
      } else if (value.error == null && value.data.isEmpty) {
        bookmarkDataStreamController.add(EmptyState(message: 'No Book Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onBookContentSelected(BookmarkDataEntity item) {
    _view.navigateToBookDetailsScreen(item);
  }

  void onBookmarkContentSelected(BookmarkDataEntity item) {
    bookmarkBookAction(
      bookId: item.book!.id,
      eMISUserId: 1,
    ).then((value) {
      if (value.error == null && value.data != null) {
        _bookList.removeWhere((element) => element.bookId == value.data.bookId);
        bookmarkDataStreamController
            .add(DataLoadedState<List<BookmarkDataEntity>>(_bookList));
        if (_bookList.isEmpty) {
          bookmarkDataStreamController
              .add(EmptyState(message: 'No Book Found'));
        }
        _view.showSuccess(item.status == 0
            ? "বুকমার্ক সফলভাবে যোগ করা হয়েছে !"
            : "বুকমার্ক সফলভাবে মুছে ফেলা হয়েছে !");
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onTapNotification() {
    _view.navigateToNotificationScreen();
  }

  void onTapTag(TagDataEntity data) {
    _view.navigateToTagBookScreen(data);
  }
}
