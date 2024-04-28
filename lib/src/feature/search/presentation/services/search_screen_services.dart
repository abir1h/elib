import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../book/data/data_sources/remote/book_data_source.dart';
import '../../../book/data/repositories/book_repository_imp.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../../../book/domain/use_cases/book_use_case.dart';
import '../../../home/presentation/services/home_service.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../widgets/checkbox_widget.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToBookDetailsScreen(BookDataEntity data);
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
    bookDataStreamController.add(EmptyState(
      message: "",
      icon: Icons.search_rounded,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    resultsForStreamController.dispose();
    bookDataStreamController.dispose();
  }

  List<BookDataEntity> _bookData = [];
  String _selectedCheckBoxValue = CheckBoxSelection.all.name;
  final AppStreamController<ResultsForViewModel> resultsForStreamController =
      AppStreamController();
  final AppStreamController<List<BookDataEntity>> bookDataStreamController =
      AppStreamController();

  onCheckBoxValue(String value) {
    _selectedCheckBoxValue = value;
  }

  onSearchTermChanged(String value) {
    resultsForStreamController
        .add(DataLoadedState(ResultsForViewModel.search(value)));
    bookDataStreamController.add(LoadingState());
    if (value.isNotEmpty) {
      globalSearch(value, _selectedCheckBoxValue).then((value) {
        if (value.error == null && value.data!.isNotEmpty) {
          _bookData = value.data;
          bookDataStreamController
              .add(DataLoadedState<List<BookDataEntity>>(_bookData));
        } else if (value.error == null && value.data!.isEmpty) {
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

  void onTapBook(BookDataEntity item) {
    _view.navigateToBookDetailsScreen(item);
  }
}
