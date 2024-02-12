import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/paginated_gridview_widget.dart';
import '../../../author/data/data_sources/remote/author_data_source.dart';
import '../../../author/data/repositories/author_repository_imp.dart';
import '../../../author/domain/entities/author_data_entity.dart';
import '../../../author/domain/use_cases/author_use_case.dart';
import '../../../book/data/data_sources/remote/book_data_source.dart';
import '../../../book/data/repositories/book_repository_imp.dart';
import '../../../book/domain/use_cases/book_use_case.dart';
import '../../../bookmark/data/data_sources/remote/bookmark_data_source.dart';
import '../../../bookmark/data/repositories/bookmark_repository_imp.dart';
import '../../../bookmark/domain/use_cases/book_mark_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../../core/utility/app_label.dart';
import '../../../book/domain/entities/book_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToNotificationScreen();
  void navigateToBookDetailsScreen(BookDataEntity data);
  void navigateToAllAuthorScreen();
  void navigateToAuthorBooksScreen(AuthorDataEntity authorDataEntity);

  // void showVideoPlayerDialog(ELibraryEntity item);
  // void navigateToDocumentViewerScreen(ELibraryEntity item);
}

mixin HomeScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  // late ServiceState serviceState = ServiceState();
  // PaginatedGridViewController<PaginatedGridViewController<BookDataEntity>> paginationController = PaginatedGridViewController();

  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
          BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> getPopularBooks(int pageNumber) async {
    return _bookUseCase.getPopularBooksUseCase(pageNumber);
  }

  Future<ResponseEntity> globalSearch(String searchQuery) async {
    return _bookUseCase.globalSearchUseCase(searchQuery);
  }

  final BookmarkUseCase _bookmarkUseCase = BookmarkUseCase(
      bookmarkRepository: BookmarkRepositoryImp(
          bookmarkRemoteDataSource: BookmarkRemoteDataSourceImp()));

  Future<ResponseEntity> bookmarkBookAction(
      {required int bookId, required int eMISUserId}) async {
    return _bookmarkUseCase.bookmarkUseCase(bookId, eMISUserId);
  }

  final AuthorUseCase _authorUseCase = AuthorUseCase(
      authorRepository: AuthorRepositoryImp(
          authorRemoteDataSource: AuthorRemoteDataSourceImp()));

  Future<ResponseEntity> getAuthors() async {
    return _authorUseCase.getAuthorsUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    // paginationController.onLoadMore = _onLoadMoreItems;
    super.initState();
    _loadInitialData();
    _loadAuthorData();
  }

  @override
  void dispose() {
    authorDataStreamController.dispose();
    // eLibraryDataStreamController.dispose();
    // resultsForStreamController.dispose();
    // paginationController.dispose();
    // serviceState.dispose();
    super.dispose();
  }

  ///Stream controllers
  // final AppStreamController<PaginatedGridViewController<BookDataEntity>> eLibraryDataStreamController = AppStreamController();
  // final AppStreamController<ResultsForViewModel> resultsForStreamController = AppStreamController();
  final AppStreamController<List<BookDataEntity>> bookDataStreamController =
      AppStreamController();
  final AppStreamController<ResultsForViewModel> resultsForStreamController =
      AppStreamController();
  final AppStreamController<List<AuthorDataEntity>> authorDataStreamController =
      AppStreamController();

  List<BookDataEntity> _bookData = [];

  ///Load Book list
  void _loadInitialData() {
    ///Loading state
    if (!mounted) return;
    bookDataStreamController.add(LoadingState());
    resultsForStreamController
        .add(DataLoadedState(ResultsForViewModel.newUploads()));
    getPopularBooks(1).then((value) {
      if (value.error == null && value.data.bookDataEntity!.isNotEmpty) {
        _bookData = value.data!.bookDataEntity;
        bookDataStreamController
            .add(DataLoadedState<List<BookDataEntity>>(_bookData));
      } else if (value.error == null && value.data.bookDataEntity!.isEmpty) {
        bookDataStreamController.add(EmptyState(message: 'No Book Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///Load Auth list
  void _loadAuthorData() {
    if (!mounted) return;
    authorDataStreamController.add(LoadingState());
    getAuthors().then((value) {
      if (value.error == null && value.data.authorDataEntity.isNotEmpty) {
        authorDataStreamController.add(DataLoadedState<List<AuthorDataEntity>>(
            value.data.authorDataEntity));
      } else if (value.error == null && value.data.authorDataEntity.isEmpty) {
        authorDataStreamController.add(EmptyState(message: 'No Author Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onBookContentSelected(BookDataEntity item) {
    _view.navigateToBookDetailsScreen(item);
  }

  void onBookmarkContentSelected(BookDataEntity item) {
    bookmarkBookAction(
      bookId: item.id,
      eMISUserId: 1,
    ).then((value) {
      if (value.error == null && value.data != null) {
        int index = _bookData.indexWhere((element) => element.id == item.id);
        _bookData[index].bookMark = !_bookData[index].bookMark;
        bookDataStreamController
            .add(DataLoadedState<List<BookDataEntity>>(_bookData));
        _view.showSuccess(item.bookMark
            ? "বুকমার্ক সফলভাবে যোগ করা হয়েছে !"
            : "বুকমার্ক সফলভাবে মুছে ফেলা হয়েছে !");
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  onSearchTermChanged(String value) {
    if (value.isNotEmpty) {
      resultsForStreamController
          .add(DataLoadedState(ResultsForViewModel.search(value)));
      globalSearch(value).then((value) {
        if (value.error == null && value.data.bookDataEntity!.isNotEmpty) {
          _bookData = value.data!.bookDataEntity;
          bookDataStreamController
              .add(DataLoadedState<List<BookDataEntity>>(_bookData));
        } else if (value.error == null && value.data.bookDataEntity!.isEmpty) {
          bookDataStreamController.add(EmptyState(
            message: "No Book found!",
            icon: Icons.search_rounded,
          ));
        } else {
          _view.showWarning(value.message!);
        }
      });
    } else {
      _loadInitialData();
    }
  }

  void onTapAuthorSeeAll() {
    _view.navigateToAllAuthorScreen();
  }

  void onTapAuthor(AuthorDataEntity authorDataEntity) {
    _view.navigateToAuthorBooksScreen(authorDataEntity);
  }

  void onTapNotification() {
    _view.navigateToNotificationScreen();
  }
}

class ResultsForViewModel {
  late final String title;
  late final String subTitle;

  ResultsForViewModel.newUploads() {
    title = label(e: "Popular Books", b: "জনপ্রিয় বই");
    subTitle = "";
  }
  ResultsForViewModel.search(String searchTerm) {
    title = "Search Result";
    subTitle = 'Showing results for "$searchTerm"';
  }
}
