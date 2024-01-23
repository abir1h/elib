import '../../../book/data/mapper/book_data_mapper.dart';
import '../../../book/data/models/book_data_model.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../mapper/paginated_category_data_mapper.dart';
import '../../domain/entities/paginated_category_data_entity.dart';
import '../mapper/category_data_mapper.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../domain/entities/category_data_entity.dart';
import '../data_sources/remote/category_data_source.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/paginated_category_data_model.dart';
import '../models/category_data_model.dart';

class CategoryRepositoryImp extends CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;
  CategoryRepositoryImp({required this.categoryRemoteDataSource});

  @override
  Future<ResponseEntity> getCategories() async {
    ResponseModel responseModel =
        (await categoryRemoteDataSource.getCategoriesAction());
    return ResponseModelToEntityMapper<List<CategoryDataEntity>,
            List<CategoryDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<CategoryDataModel> models) =>
                List<CategoryDataModel>.from(models)
                    .map((e) => e.toCategoryDataEntity)
                    .toList());
  }

  @override
  Future<ResponseEntity> getCategoryWithBook() async {
    ResponseModel responseModel =
        (await categoryRemoteDataSource.getCategoryWithBookAction());
    return ResponseModelToEntityMapper<PaginatedCategoryDataEntity,
            PaginatedCategoryDataModel>()
        .toEntityFromModel(
            responseModel,
            (PaginatedCategoryDataModel model) =>
                model.toPaginatedCategoryDataEntity);
  }

  @override
  Future<ResponseEntity> getCategoryById(int categoryId) async {
    ResponseModel responseModel =
        (await categoryRemoteDataSource.getCategoryByIdAction(categoryId));
    return ResponseModelToEntityMapper<List<BookDataEntity>,
            List<BookDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<BookDataModel> models) => List<BookDataModel>.from(models)
                .map((e) => e.toBookDataEntity)
                .toList());
  }
}
