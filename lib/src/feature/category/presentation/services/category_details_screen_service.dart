import 'package:elibrary/src/feature/category/data/data_sources/remote/category_data_source.dart';
import 'package:elibrary/src/feature/category/data/repositories/category_repository_imp.dart';
import 'package:elibrary/src/feature/category/domain/use_cases/category_use_case.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../book/data/data_sources/remote/book_data_source.dart';
import '../../../book/data/repositories/book_repository_imp.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../book/domain/use_cases/book_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToBookDetailsScreen(BookDataEntity data);
}

mixin CategoryDetailsScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  final CategoryUseCase _categoryUseCase = CategoryUseCase(
    categoryRepository: CategoryRepositoryImp(
        categoryRemoteDataSource: CategoryRemoteDataSourceImp()),
  );

  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
      BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> bookmarkBookAction(
      {required int bookId, required int eMISUserId}) async {
    return _bookUseCase.bookmarkUseCase(bookId, eMISUserId);
  }
  // Future<ResponseEntity> getBookmarkBookList(int id) async {
  //   return _categoryUseCase.getCategoryByIdUseCase(id);
  // }

  Future<ResponseEntity> getCategoryBookList(int id) async {
    return _categoryUseCase.getCategoryByIdUseCase(id);
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
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<BookDataEntity>> bookDataStreamController =
      AppStreamController();

  loadBookListData(int id) {
    if (!mounted) return;
    bookDataStreamController.add(LoadingState());
    getCategoryBookList(id).then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        _bookList = value.data;
        bookDataStreamController
            .add(DataLoadedState<List<BookDataEntity>>(value.data!));
      } else if (value.error == null &&  value.data.isEmpty) {
        bookDataStreamController.add(EmptyState(message: 'No Book Found'));
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
        bookDataStreamController
            .add(DataLoadedState<List<BookDataEntity>>(_bookList));
        _view.showSuccess(item.bookMark?"বুকমার্ক সফলভাবে যোগ করা হয়েছে !":"বুকমার্ক সফলভাবে মুছে ফেলা হয়েছে !");
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

}
