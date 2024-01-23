import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository _profileRepository;
  ProfileUseCase({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  Future<ResponseEntity> userProfileInformationUseCase() async {
    final response = _profileRepository.userProfileInformation();
    return response;
  }
}
