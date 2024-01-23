import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/category_repository.dart';

class CategoryUseCase {
  final CategoryRepository _categoryRepository;
  CategoryUseCase({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository;

  Future<ResponseEntity> getCategoriesUseCase() async {
    final response = _categoryRepository.getCategories();
    return response;
  }

  Future<ResponseEntity> getCategoryWithBookUseCase() async {
    final response = _categoryRepository.getCategoryWithBook();
    return response;
  }

  Future<ResponseEntity> getCategoryByIdUseCase(int categoryId) async {
    final response = _categoryRepository.getCategoryById(categoryId);
    return response;
  }

}