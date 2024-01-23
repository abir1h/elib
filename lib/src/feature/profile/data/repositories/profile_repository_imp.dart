import '../mapper/profile_data_mapper.dart';
import '../models/profile_data_model.dart';
import '../../domain/entities/profile_data_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/remote/profile_data_source.dart';

class ProfileRepositoryImp extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImp({required this.profileRemoteDataSource});

  @override
  Future<ResponseEntity> userProfileInformation() async {
    ResponseModel responseModel =
        (await profileRemoteDataSource.userProfileInformationAction());
    return ResponseModelToEntityMapper<ProfileDataEntity, ProfileDataModel>()
        .toEntityFromModel(responseModel,
            (ProfileDataModel model) => model.toProfileDataEntity);
  }
}
