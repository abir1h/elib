import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/book_data_source.dart';
import '../../data/repositories/book_repository_imp.dart';
import '../../domain/entities/book_request_entity.dart';
import '../../domain/use_cases/book_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin BookRequestListScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
          BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> getBookRequestList(bool enablePagination,
      {int? pageNumber}) async {
    return _bookUseCase.getBookRequestsUseCase(enablePagination,
        pageNumber: pageNumber);
  }

  Future<ResponseEntity> createBookRequest(
      {required BookRequestDataEntity bookRequestDataEntity}) async {
    return _bookUseCase.createBookRequestUseCase(bookRequestDataEntity);
  }

  List<BookRequestDataEntity> _bookList = [];

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadBookRequestData(false);
  }

  @override
  void dispose() {
    bookRequestDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<BookRequestDataEntity>>
      bookRequestDataStreamController = AppStreamController();

  ///Load Book Request list
  void _loadBookRequestData(bool enablePagination, {int? pageNumber}) {
    if (!mounted) return;
    bookRequestDataStreamController.add(LoadingState());
    getBookRequestList(enablePagination, pageNumber: pageNumber).then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        _bookList = value.data;
        bookRequestDataStreamController
            .add(DataLoadedState<List<BookRequestDataEntity>>(value.data));
      } else if (value.error == null && value.data.isEmpty) {
        bookRequestDataStreamController
            .add(EmptyState(message: 'No Requested Book Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void onBookmarkContentSelected(BookRequestDataEntity item) {
    createBookRequest(bookRequestDataEntity: item).then((value) {
      if (value.error == null && value.data != null) {
        bookRequestDataStreamController
            .add(DataLoadedState<List<BookRequestDataEntity>>(_bookList));
        if (_bookList.isEmpty) {
          bookRequestDataStreamController
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
}
