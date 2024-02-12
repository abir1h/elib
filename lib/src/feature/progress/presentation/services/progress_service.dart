import '../../domain/use_cases/progress_use_case.dart';
import '../../data/data_sources/remote/progress_data_source.dart';
import '../../data/repositories/progress_repository_imp.dart';
import '../../../shared/domain/entities/response_entity.dart';

mixin class ProgressService {
  ProgressService._();
  final ProgressUseCase _progressUseCase = ProgressUseCase(
      progressRepository: ProgressRepositoryImp(
          progressRemoteDataSource: ProgressRemoteDataSourceImp()));

  Future<ResponseEntity> getProgressCounts() async {
    return _progressUseCase.getProgressCountsUseCase();
  }

  Future<ResponseEntity> getUserReadBooks() async {
    return _progressUseCase.getUserReadBooksUseCase();
  }
}
