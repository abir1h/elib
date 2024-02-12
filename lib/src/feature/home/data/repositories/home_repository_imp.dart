import '../mapper/home_data_mapper.dart';
import '../models/home_data_model.dart';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/remote/home_data_source.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../shared/data/models/response_model.dart';

class HomeRepositoryImp extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImp({required this.homeRemoteDataSource});

  @override
  Future<ResponseEntity> getHome() async {
    ResponseModel responseModel = (await homeRemoteDataSource.getHomeAction());
    return ResponseModelToEntityMapper<HomeDataEntity, HomeDataModel>()
        .toEntityFromModel(
            responseModel, (HomeDataModel model) => model.toHomeDataEntity);
  }
}
