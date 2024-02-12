import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/home_repository.dart';

class HomeUseCase {
  final HomeRepository _homeRepository;
  HomeUseCase({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  Future<ResponseEntity> getHomeUseCase() async {
    final response = _homeRepository.getHome();
    return response;
  }
}
