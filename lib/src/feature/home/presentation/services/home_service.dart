import 'dart:async';

import 'package:elibrary/src/feature/book/domain/entities/book_data_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/paginated_gridview_widget.dart';
import '../../../book/data/data_sources/remote/book_data_source.dart';
import '../../../book/data/repositories/book_repository_imp.dart';
import '../../../book/domain/use_cases/book_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToBookDetailsScreen(BookDataEntity data);
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

  Future<ResponseEntity> bookmarkBookAction(
      {required int bookId, required int eMISUserId}) async {
    return _bookUseCase.bookmarkUseCase(bookId, eMISUserId);
  }

  Future<ResponseEntity> globalSearch(String searchQuery) async {
    return _bookUseCase.globalSearchUseCase(searchQuery);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    // paginationController.onLoadMore = _onLoadMoreItems;
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
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
            message: "No item found!",
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
}

class ResultsForViewModel {
  late final String title;
  late final String subTitle;

  ResultsForViewModel.newUploads() {
    title = "Popular Books";
    subTitle = "";
  }
  ResultsForViewModel.search(String searchTerm) {
    title = "Search Result";
    subTitle = 'Showing results for "$searchTerm"';
  }
}
