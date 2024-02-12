import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../bookmark/data/data_sources/remote/bookmark_data_source.dart';
import '../../../bookmark/data/repositories/bookmark_repository_imp.dart';
import '../../../bookmark/domain/use_cases/book_mark_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../data/data_sources/remote/book_data_source.dart';
import '../../data/repositories/book_repository_imp.dart';
import '../../domain/use_cases/book_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToBookDetailsScreen(BookDataEntity data);
}

mixin TagBookScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
          BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> getBookByTag(int tagId) async {
    return _bookUseCase.getBooksByTagsUseCase(tagId);
  }

  final BookmarkUseCase _bookmarkUseCase = BookmarkUseCase(
      bookmarkRepository: BookmarkRepositoryImp(
          bookmarkRemoteDataSource: BookmarkRemoteDataSourceImp()));

  Future<ResponseEntity> bookmarkBookAction(
      {required int bookId, required int eMISUserId}) async {
    return _bookmarkUseCase.bookmarkUseCase(bookId, eMISUserId);
  }

  List<BookDataEntity> _bookList = [];

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    tagBooksDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<BookDataEntity>> tagBooksDataStreamController =
      AppStreamController();

  ///Load Auth list
  void loadTagBooksData(int tagId) {
    if (!mounted) return;
    tagBooksDataStreamController.add(LoadingState());
    getBookByTag(tagId).then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        _bookList = value.data;
        tagBooksDataStreamController
            .add(DataLoadedState<List<BookDataEntity>>(value.data));
      } else if (value.error == null && value.data.isEmpty) {
        tagBooksDataStreamController.add(EmptyState(message: 'No Book Found'));
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
        _bookList[index].bookMark = !_bookList[index].bookMark;
        tagBooksDataStreamController
            .add(DataLoadedState<List<BookDataEntity>>(_bookList));
        _view.showSuccess(item.bookMark
            ? "বুকমার্ক সফলভাবে যোগ করা হয়েছে !"
            : "বুকমার্ক সফলভাবে মুছে ফেলা হয়েছে !");
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
