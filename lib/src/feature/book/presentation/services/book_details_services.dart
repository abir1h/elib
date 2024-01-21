import 'dart:async';

import 'package:elibrary/src/core/routes/app_route_args.dart';
import 'package:elibrary/src/feature/book/domain/entities/book_data_entity.dart';
import 'package:elibrary/src/feature/category/domain/entities/category_book_data_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/paginated_gridview_widget.dart';
import '../../../book/data/data_sources/remote/book_data_source.dart';
import '../../../book/data/repositories/book_repository_imp.dart';
import '../../../book/domain/use_cases/book_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin BookDetailsScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;

  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
      BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> getBookDetails(int bookId) async {
    return _bookUseCase.getBookDetailsUseCase(bookId);
  }

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
  final AppStreamController<BookDataEntity> bookDataStreamController =
  AppStreamController();

  ///Load Book list
  void loadInitialData(BookDetailsScreenArgs args) {
    ///Loading state
    if (!mounted) return;
    bookDataStreamController.add(LoadingState());
    getBookDetails(args.bookId).then((value) {
      if (value.error == null && value.data!=null) {

      }  else {
        _view.showWarning(value.message!);
      }
    });
  }

}