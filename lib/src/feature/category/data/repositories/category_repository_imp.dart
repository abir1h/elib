import 'package:elibrary/src/feature/category/data/data_sources/remote/category_data_source.dart';
import 'package:elibrary/src/feature/shared/domain/entities/response_entity.dart';

import '../../domain/repositories/category_repository.dart';

class CategoryRepositoryImp extends CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;
  CategoryRepositoryImp({required this.categoryRemoteDataSource});

  @override
  Future<ResponseEntity> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }


}