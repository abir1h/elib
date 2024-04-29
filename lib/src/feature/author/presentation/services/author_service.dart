import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/paginated_list_view.dart';
import '../../data/data_sources/remote/author_data_source.dart';
import '../../data/repositories/author_repository_imp.dart';
import '../../domain/use_cases/author_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/author_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToAuthorBooksScreen(AuthorDataEntity authorDataEntity);
}

mixin AuthorService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final AuthorUseCase _authorUseCase = AuthorUseCase(
      authorRepository: AuthorRepositoryImp(
          authorRemoteDataSource: AuthorRemoteDataSourceImp()));

  Future<ResponseEntity> getAuthors(int currentPage) async {
    return _authorUseCase.getAuthorsUseCase(currentPage);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadAuthorData();
    paginationController.onLoadMore = _onLoadMoreItems;
  }

  @override
  void dispose() {
    pageStateStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
 final AppStreamController<PaginatedListViewController<AuthorDataEntity>> pageStateStreamController = AppStreamController();
  PaginatedListViewController<AuthorDataEntity> paginationController = PaginatedListViewController();

  // final AppStreamController<List<AuthorDataEntity>> authorDataStreamController =
  //     AppStreamController();

  ///Load Auth list
  void _loadAuthorData() {
    if(!mounted) return;
    paginationController.clear();
    pageStateStreamController.add(LoadingState());

    getAuthors(1).then((value) {
      if (value.error == null && value.data.authorDataEntity.isNotEmpty) {
        // authorDataStreamController.add(DataLoadedState<List<AuthorDataEntity>>(
        //     value.data.authorDataEntity));
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.authorDataEntity);
        pageStateStreamController.add(DataLoadedState(paginationController));
      } else if (value.error == null && value.data.authorDataEntity.isEmpty) {
        pageStateStreamController.add(EmptyState(message: 'No Author Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }  ///On Tap Author
  void onTapAuthor(AuthorDataEntity authorDataEntity) {
    _view.navigateToAuthorBooksScreen(authorDataEntity);
  }



  ///Load more data
  Future<bool> _onLoadMoreItems(int nextPage) async{
    Completer<bool> completer = Completer();
    getAuthors(nextPage).asStream().listen((value) {
      if (!mounted) return;
      ///Data loaded state
      if(value.error == null && value.data.authorDataEntity.isNotEmpty){
        paginationController.setTotalItemCount(value.data!.total);
        paginationController.addItems(value.data!.authorDataEntity);
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
