import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../bookmark/data/data_sources/remote/bookmark_data_source.dart';
import '../../../bookmark/data/repositories/bookmark_repository_imp.dart';
import '../../../bookmark/domain/use_cases/book_mark_use_case.dart';
import '../../data/data_sources/remote/author_data_source.dart';
import '../../data/repositories/author_repository_imp.dart';
import '../../domain/use_cases/author_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../book/domain/entities/book_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToBookDetailsScreen(BookDataEntity data);
}

mixin AuthorBooksScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final AuthorUseCase _authorUseCase = AuthorUseCase(
      authorRepository: AuthorRepositoryImp(
          authorRemoteDataSource: AuthorRemoteDataSourceImp()));

  Future<ResponseEntity> getBooksByAuthors(int authorId) async {
    return _authorUseCase.getBookByAuthorsUseCase(authorId);
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
    authorBooksDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<BookDataEntity>>
      authorBooksDataStreamController = AppStreamController();

  ///Load Auth list
  void loadAuthorBooksData(int authorId) {
    if (!mounted) return;
    authorBooksDataStreamController.add(LoadingState());
    getBooksByAuthors(authorId).then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        _bookList = value.data.first.authorBook!;
        authorBooksDataStreamController
            .add(DataLoadedState<List<BookDataEntity>>(value.data.first.authorBook!));
      } else if (value.error == null && value.data.isEmpty) {
        authorBooksDataStreamController
            .add(EmptyState(message: 'No Book Found'));
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
        authorBooksDataStreamController
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
