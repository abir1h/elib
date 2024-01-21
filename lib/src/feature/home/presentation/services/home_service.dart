

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/paginated_gridview_widget.dart';

abstract class _ViewModel {
  void showWarning(String message);

  // void showVideoPlayerDialog(ELibraryEntity item);
  // void navigateToDocumentViewerScreen(ELibraryEntity item);
}

mixin HomeScreenService<T extends StatefulWidget> on State<T> implements _ViewModel {
  late _ViewModel _view;
  late ServiceState serviceState = ServiceState();
  PaginatedGridViewController<ELibraryEntity> paginationController = PaginatedGridViewController();

  ///Service configurations
  @override
  void initState() {
    _view = this;
    paginationController.onLoadMore = _onLoadMoreItems;
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    eLibraryDataStreamController.dispose();
    resultsForStreamController.dispose();
    paginationController.dispose();
    serviceState.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<PaginatedGridViewController<ELibraryEntity>> eLibraryDataStreamController = AppStreamController();
  final AppStreamController<ResultsForViewModel> resultsForStreamController = AppStreamController();



  ///Load Book list
  void _loadInitialData() {
    // ///Loading state
    // if(!mounted) return;
    // paginationController.clear();
    // eLibraryDataStreamController.add(LoadingState());
    // resultsForStreamController.add(DataLoadedState(ResultsForViewModel.newUploads()));
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


  void onLoadCategoryList() {
    ///Loading state
    if(!mounted) return;
    ELibraryGateway.getAllCategoryList().then((value){
      if(!mounted) return;

      ///Data loaded state
      if(value.status == Status.success && value.data!.isNotEmpty){
        serviceState.addToCategoryStream(DataLoadedState<List<CategoryEntity>>(value.data!));
      }
      ///Empty state
      else if(value.status == Status.success ){
        serviceState.addToCategoryStream(EmptyState(
          message: "No item found!",
        ));
      }
      ///Error state
      else{
        _view.showWarning(value.message);
        serviceState.addToCategoryStream(EmptyState(
          message: "Failed to load!",
        ));
      }
    });
  }
  ///Once user change category selection
  void onCategorySelected(CategoryEntity item) {
    onSearchTermChanged(serviceState.searchTerm);
  }

  ///This is used to handle search contents. It fires when user change any search term
  void onSearchTermChanged(String value) {
    if(!mounted) return;

    if(serviceState.searchTerm.isNotEmpty || serviceState.selectedCategory.id > 0){
      serviceState.addToSearchActivityStream(true);

      ELibraryGateway.getContentListWithPagination(serviceState.getPaginatedAndFilteredUrlSegment(paginationController.pageSize,0),).then((value){
        if(!mounted) return;

        paginationController.clear();
        serviceState.addToSearchActivityStream(false);
        resultsForStreamController.add(DataLoadedState(ResultsForViewModel.search(serviceState.searchTerm, serviceState.selectedCategory.title)));

        ///Data loaded state
        if(value.status == Status.success && value.data!.total > 0){
          paginationController.setTotalItemCount(value.data!.total);
          paginationController.addItems(value.data!.records);
          eLibraryDataStreamController.add(DataLoadedState(paginationController));
        }
        ///Empty state
        else if(value.status == Status.success && value.data!.total <= 0){
          eLibraryDataStreamController.add(EmptyState(
            message: "No item found!",
            icon: Icons.search_rounded,
          ));
        }
        ///Error state
        else{
          _view.showWarning(value.message);
        }
      });
    }
    else{
      _loadInitialData();
    }
  }

  ///Load more data
  Future<bool> _onLoadMoreItems(int nextPage) async{
    Completer<bool> _completer = Completer();
    ELibraryGateway.getContentListWithPagination(serviceState.getPaginatedAndFilteredUrlSegment(
      paginationController.pageSize,
      paginationController.nextPage,
    ),).asStream().listen((value) {
      if (!mounted) return;
      ///Data loaded state
      if(value.status == Status.success && value.data!.total > 0){
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.records);
        _completer.complete(true);
      }
      ///Error state
      else{
        ///Try reloading
        _view.showWarning(value.message);
        _completer.complete(false);
      }
    });

    return _completer.future;
  }


  ///Once user select any e-library item, navigate to appropriate details screen
  void onELibraryContentSelected(ELibraryEntity item) {

  }
}


class ResultsForViewModel{
  late final String title;
  late final String subTitle;

  ResultsForViewModel.newUploads(){
    title = "New Uploads";
    subTitle ="";
  }
  ResultsForViewModel.search(String searchTerm, String categoryName){
    title = "Search Result";
    subTitle ="Showing results ${searchTerm.isNotEmpty?"for \"$searchTerm\"":""} in ${categoryName.isNotEmpty? "\"$categoryName\" category.":"all categories."}";
  }
}