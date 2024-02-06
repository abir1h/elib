import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../data/data_sources/remote/category_data_source.dart';
import '../../data/repositories/category_repository_imp.dart';
import '../../domain/use_cases/category_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/category_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToCategoryDetailsScreen(
      String categoryNameEn, String categoryNameBn, int id);
}

mixin CategoriesScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final CategoryUseCase _categoryUseCase = CategoryUseCase(
      categoryRepository: CategoryRepositoryImp(
          categoryRemoteDataSource: CategoryRemoteDataSourceImp()));

  Future<ResponseEntity> getCategories() async {
    return _categoryUseCase.getCategoriesUseCase();
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
    getCategories().then((value) {
      if (value.error == null && value.data.isNotEmpty) {
        categoryDataStreamController
            .add(DataLoadedState<List<CategoryDataEntity>>(value.data));
      } else if (value.error == null && value.data.isEmpty) {
        categoryDataStreamController
            .add(EmptyState(message: 'No Category Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///On Tap See All
  void onTapCategory(String categoryNameEn, String categoryNameBn, int id) {
    _view.navigateToCategoryDetailsScreen(categoryNameEn, categoryNameBn, id);
  }
}
