import '../../data/data_sources/remote/category_data_source.dart';
import '../../data/repositories/category_repository_imp.dart';
import '../../domain/use_cases/category_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

mixin class CategoryService {
  CategoryService._();
  final CategoryUseCase _categoryUseCase = CategoryUseCase(
      categoryRepository: CategoryRepositoryImp(
          categoryRemoteDataSource: CategoryRemoteDataSourceImp()));

  Future<ResponseEntity> getCategories() async {
    return _categoryUseCase.getCategoriesUseCase();
  }

  Future<ResponseEntity> getCategoryWithBook() async {
    return _categoryUseCase.getCategoryWithBookUseCase();
  }
}
