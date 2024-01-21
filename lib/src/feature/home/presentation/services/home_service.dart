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

  ///Load Book list
  void _loadInitialData() {
    ///Loading state
    if (!mounted) return;
    bookDataStreamController.add(LoadingState());
    getPopularBooks(1).then((value) {
        if(value.error == null && value.data.bookDataEntity!.isNotEmpty) {
          bookDataStreamController.add(DataLoadedState<List<BookDataEntity>>(
              value.data!.bookDataEntity));
        }else if(value.error == null && value.data.bookDataEntity!.isEmpty){

        }else{
          _view.showWarning(value.message!);
        }
    });

    // ///Loading state
    // if(!mounted) return;
    // paginationController.clear();
    // eLibraryDataStreamController.add(LoadingState());
    // // resultsForStreamController.add(DataLoadedState(ResultsForViewModel.newUploads()));
    // getPopularBooks(paginationController.pageSize).then((value) {
    //   if (!mounted) return;
    //   if(value.error == null && value.data != null && value.data!.total > 0){
    //     paginationController.setTotalItemCount(value.data!.total);
    //     paginationController.addItems(value.data.bookDataEntity);
    //     // eLibraryDataStreamController.add(DataLoadedState(paginationController));
    //   }
    //
    // });
    // ELibraryGateway.getContentListWithPagination(serviceState.getPaginatedAndFilteredUrlSegment(paginationController.pageSize,0),).then((value){
    //   if (!mounted) return;
    //   ///Data loaded state
    //   if(value.status == Status.success && value.data!.total > 0){
    //     paginationController.setTotalItemCount(value.data!.total);
    //     paginationController.addItems(value.data!.records);
    //     eLibraryDataStreamController.add(DataLoadedState(paginationController));
    //   }
    //   ///Empty state
    //   else if(value.status == Status.success && value.data!.total <= 0){
    //     eLibraryDataStreamController.add(EmptyState(
    //       message: "No e-library content is available!",
    //       icon: Icons.layers_outlined,
    //     ));
    //   }
    //   ///Error state
    //   else{
    //     ///Try reloading
    //     _view.showWarning(value.message);
    //     Future.delayed( Duration(seconds: AppConstant.reloadInSeconds)).then((value){
    //       if(mounted) _loadInitialData();
    //     });
    //   }
    // });
  }
  void onBookContentSelected(BookDataEntity item) {
    _view.navigateToBookDetailsScreen(item);
  }
  // void onLoadCategoryList() {
  //   ///Loading state
  //   if(!mounted) return;
  //   ELibraryGateway.getAllCategoryList().then((value){
  //     if(!mounted) return;
  //
  //     ///Data loaded state
  //     if(value.status == Status.success && value.data!.isNotEmpty){
  //       serviceState.addToCategoryStream(DataLoadedState<List<CategoryEntity>>(value.data!));
  //     }
  //     ///Empty state
  //     else if(value.status == Status.success ){
  //       serviceState.addToCategoryStream(EmptyState(
  //         message: "No item found!",
  //       ));
  //     }
  //     ///Error state
  //     else{
  //       _view.showWarning(value.message);
  //       serviceState.addToCategoryStream(EmptyState(
  //         message: "Failed to load!",
  //       ));
  //     }
  //   });
  // }
  ///Once user change category selection
  // void onCategorySelected(CategoryEntity item) {
  //   onSearchTermChanged(serviceState.searchTerm);
  // }

  ///This is used to handle search contents. It fires when user change any search term
  // void onSearchTermChanged(String value) {
  //   if(!mounted) return;
  //
  //   if(serviceState.searchTerm.isNotEmpty || serviceState.selectedCategory.id > 0){
  //     serviceState.addToSearchActivityStream(true);
  //
  //     ELibraryGateway.getContentListWithPagination(serviceState.getPaginatedAndFilteredUrlSegment(paginationController.pageSize,0),).then((value){
  //       if(!mounted) return;
  //
  //       paginationController.clear();
  //       serviceState.addToSearchActivityStream(false);
  //       resultsForStreamController.add(DataLoadedState(ResultsForViewModel.search(serviceState.searchTerm, serviceState.selectedCategory.title)));
  //
  //       ///Data loaded state
  //       if(value.status == Status.success && value.data!.total > 0){
  //         paginationController.setTotalItemCount(value.data!.total);
  //         paginationController.addItems(value.data!.records);
  //         eLibraryDataStreamController.add(DataLoadedState(paginationController));
  //       }
  //       ///Empty state
  //       else if(value.status == Status.success && value.data!.total <= 0){
  //         eLibraryDataStreamController.add(EmptyState(
  //           message: "No item found!",
  //           icon: Icons.search_rounded,
  //         ));
  //       }
  //       ///Error state
  //       else{
  //         _view.showWarning(value.message);
  //       }
  //     });
  //   }
  //   else{
  //     _loadInitialData();
  //   }
  // }
  //
  // ///Load more data
  // Future<bool> _onLoadMoreItems(int nextPage) async{
  //   Completer<bool> completer = Completer();
  //   getPopularBooks(paginationController.pageSize).asStream().listen((value) {
  //     if (!mounted) return;
  //     ///Data loaded state
  //     if(value.error != null && value.data != null && value.data!.total > 0){
  //       paginationController.setTotalItemCount(value.data!.total);
  //       paginationController.addItems(value.data!.records);
  //       completer.complete(true);
  //     }
  //     ///Error state
  //     else{
  //       ///Try reloading
  //       _view.showWarning("");
  //       completer.complete(false);
  //     }
  //   });
  //
  //   return completer.future;
  // }


}

class ResultsForViewModel {
  late final String title;
  late final String subTitle;

  ResultsForViewModel.newUploads() {
    title = "New Uploads";
    subTitle = "";
  }
  ResultsForViewModel.search(String searchTerm, String categoryName) {
    title = "Search Result";
    subTitle =
        "Showing results ${searchTerm.isNotEmpty ? "for \"$searchTerm\"" : ""} in ${categoryName.isNotEmpty ? "\"$categoryName\" category." : "all categories."}";
  }
}
