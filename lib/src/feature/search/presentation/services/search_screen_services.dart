import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../book/data/data_sources/remote/book_data_source.dart';
import '../../../book/data/repositories/book_repository_imp.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../book/domain/use_cases/book_use_case.dart';
import '../../../home/presentation/services/home_service.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin SearchScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;

  final BookUseCase _bookUseCase = BookUseCase(
      bookRepository:
      BookRepositoryImp(bookRemoteDataSource: BookRemoteDataSourceImp()));

  Future<ResponseEntity> globalSearch(String searchQuery, String type) async {
    return _bookUseCase.globalSearchUseCase(searchQuery, type);
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

  List<BookDataEntity> _bookData = [];
  final AppStreamController<ResultsForViewModel> resultsForStreamController =
  AppStreamController();
  final AppStreamController<List<BookDataEntity>> bookDataStreamController =
  AppStreamController();

  onSearchTermChanged(String value) {
    if (value.isNotEmpty) {
      resultsForStreamController
          .add(DataLoadedState(ResultsForViewModel.search(value)));
      globalSearch(value, "all").then((value) {
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
      bookDataStreamController.add(EmptyState(
        message: "",
        icon: Icons.search_rounded,
      ));
    }
  }


}
