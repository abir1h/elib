import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/paginated_list_view.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/book_data_source.dart';
import '../../data/repositories/book_repository_imp.dart';
import '../../domain/entities/book_request_entity.dart';
import '../../domain/use_cases/book_use_case.dart';
import '../../../../core/common_widgets/custom_toasty.dart';

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

  Future<ResponseEntity> deleteBookRequest({required int bookRequestId}) async {
    return _bookUseCase.deleteBookRequestUseCase(bookRequestId);
  }

  List<BookRequestDataEntity> _bookList = [];

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    loadBookRequestData(true, pageNumber: 1);
    paginationController.onLoadMore = _onLoadMoreItems;
  }

  @override
  void dispose() {
    // bookRequestDataStreamController.dispose();
    pageStateStreamController.dispose();
    super.dispose();
  }

  // ///Stream controllers
  // final AppStreamController<List<BookRequestDataEntity>>
  //     bookRequestDataStreamController = AppStreamController();

  ///Stream controllers
  final AppStreamController<PaginatedListViewController<BookRequestDataEntity>> pageStateStreamController = AppStreamController();
  PaginatedListViewController<BookRequestDataEntity> paginationController = PaginatedListViewController();

  ///Load Book Request list
  void loadBookRequestData(bool enablePagination, {int? pageNumber}) {
    if(!mounted) return;
    paginationController.clear();
    pageStateStreamController.add(LoadingState());
    getBookRequestList(enablePagination, pageNumber: pageNumber).then((value) {
      if (value.error == null && value.data.bookRequestDataEntity.isNotEmpty) {
        _bookList = value.data.bookRequestDataEntity;
        // bookRequestDataStreamController.add(
        //     DataLoadedState<List<BookRequestDataEntity>>(
        //         value.data.bookRequestDataEntity));
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.bookRequestDataEntity);
        pageStateStreamController.add(DataLoadedState(paginationController));
      } else if (value.error == null &&
          value.data.bookRequestDataEntity.isEmpty) {
        pageStateStreamController
            .add(EmptyState(message: 'No Requested Book Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  Future<ResponseEntity> onBookRequestDelete(int bookRequestId) async {
    CustomToasty.of(context).lockUI();
    ResponseEntity responseEntity =
        await deleteBookRequest(bookRequestId: bookRequestId);
    if (responseEntity.error == null && responseEntity.data != null) {
      loadBookRequestData(true, pageNumber: 1);
      _view.showSuccess(responseEntity.message!);
    } else {
      _view.showWarning(responseEntity.message!);
    }
    CustomToasty.of(context).releaseUI();
    return responseEntity;
  }

  ///Load more data
  Future<bool> _onLoadMoreItems(int nextPage) async{
    Completer<bool> completer = Completer();
    getBookRequestList(true, pageNumber: nextPage).asStream().listen((value) {
      if (!mounted) return;
      ///Data loaded state
      if(value.error == null && value.data.bookRequestDataEntity.isNotEmpty){
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.bookRequestDataEntity);
        completer.complete(true);
      }
      ///Error state
      else{
        ///Try reloading
        // _view.showWarning(value.message);
        completer.complete(false);
      }
    });

    return completer.future;
  }
}
