import '../../../shared/domain/entities/response_entity.dart';

abstract class ProgressRepository {
  Future<ResponseEntity> getProgressCounts();
  Future<ResponseEntity> getUserReadBooks();
}
