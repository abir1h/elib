import '../../../shared/domain/entities/response_entity.dart';

abstract class HomeRepository {
  Future<ResponseEntity> getHome();
}
