import '../../../shared/domain/entities/response_entity.dart';

abstract class CategoryRepository {
  Future<ResponseEntity> getCategories();
  Future<ResponseEntity> getCategoryWithBook();
  Future<ResponseEntity> getCategoryById(int categoryId);
}
