import '../repositories/Progress_repository.dart';
import '../../../shared/domain/entities/response_entity.dart';

class ProgressUseCase {
  final ProgressRepository _progressRepository;
  ProgressUseCase({required ProgressRepository progressRepository})
      : _progressRepository = progressRepository;

  Future<ResponseEntity> getProgressCountsUseCase() async {
    final response = _progressRepository.getProgressCounts();
    return response;
  }
  Future<ResponseEntity> getUserReadBooksUseCase() async {
    final response = _progressRepository.getUserReadBooks();
    return response;
  }

}
