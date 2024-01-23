import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../data/data_sources/remote/category_data_source.dart';
import '../../data/repositories/category_repository_imp.dart';
import '../../domain/use_cases/category_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/category_data_entity.dart';
import '../../../book/domain/entities/book_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToCategoryDetailsScreen(
      String categoryName, List<BookDataEntity> data);
  void navigateToBookDetailsScreen(BookDataEntity data);
}

mixin CategoriesScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final CategoryUseCase _categoryUseCase = CategoryUseCase(
      categoryRepository: CategoryRepositoryImp(
          categoryRemoteDataSource: CategoryRemoteDataSourceImp()));

  Future<ResponseEntity> getCategoryWithBook() async {
    return _categoryUseCase.getCategoryWithBookUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
    _loadCategoryData();
  }

  @override
  void dispose() {
    categoryDataStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<List<CategoryDataEntity>>
      categoryDataStreamController = AppStreamController();

  ///Load Category list
  void _loadCategoryData() {
    if (!mounted) return;
    categoryDataStreamController.add(LoadingState());
    getCategoryWithBook().then((value) {
      if (value.error == null && value.data.categoryDataEntity!.isNotEmpty) {
        categoryDataStreamController.add(
            DataLoadedState<List<CategoryDataEntity>>(
                value.data!.categoryDataEntity));
      } else if (value.error == null &&
          value.data.categoryDataEntity!.isEmpty) {
        categoryDataStreamController
            .add(EmptyState(message: 'No Category Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///On Tap See All
  void onTapSeeAll(String categoryName, List<BookDataEntity> item) {
    _view.navigateToCategoryDetailsScreen(categoryName, item);
  }

  void onBookContentSelected(BookDataEntity item) {
    _view.navigateToBookDetailsScreen(item);
  }
}
