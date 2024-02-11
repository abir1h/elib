import '../mapper/progress_data_mapper.dart';
import '../models/progress_data_model.dart';
import '../../domain/entities/progress_data_entity.dart';
import '../../domain/repositories/Progress_repository.dart';
import '../data_sources/remote/progress_data_source.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../shared/data/models/response_model.dart';

class ProgressRepositoryImp extends ProgressRepository {
  final ProgressRemoteDataSource progressRemoteDataSource;
  ProgressRepositoryImp({required this.progressRemoteDataSource});

  @override
  Future<ResponseEntity> getProgressCounts() async {
    ResponseModel responseModel =
        (await progressRemoteDataSource.getProgressCountsAction());
    return ResponseModelToEntityMapper<ProgressDataEntity, ProgressDataModel>()
        .toEntityFromModel(responseModel,
            (ProgressDataModel model) => model.toProgressDataEntity);
  }
}
