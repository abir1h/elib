import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../domain/entities/category_data_entity.dart';
import '../data_sources/remote/category_data_source.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/category_data_model.dart';

class CategoryRepositoryImp extends CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;
  CategoryRepositoryImp({required this.categoryRemoteDataSource});

  // @override
  // Future<ResponseEntity> getCategories() async{
  //   ResponseModel responseModel =
  //   (await categoryRemoteDataSource.getCategoriesAction());
  //   return ResponseModelToEntityMapper<CategoryDataEntity, CategoryDataModel>()
  //       .toEntityFromModel(
  //   responseModel, (CategoryDataModel model) => model.toAuthDataEntity);
  // }

  @override
  Future<ResponseEntity> getCategories() async{
    throw UnimplementedError();
  }

}