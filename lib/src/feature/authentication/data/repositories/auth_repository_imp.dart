import '../mapper/auth_data_mapper.dart';
import '../models/auth_data_model.dart';
import '../../domain/entities/auth_data_entity.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../data_sources/remote/auth_data_source.dart';
import '../../domain/repositories/auth_repository.dart';


class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp({required this.authRemoteDataSource});

  @override
  Future<ResponseEntity> getToken(String username, String eMISToken) async {
    ResponseModel responseModel =
        (await authRemoteDataSource.getTokenAction(username, eMISToken));
    return ResponseModelToEntityMapper<AuthDataEntity, AuthDataModel>()
        .toEntityFromModel(
            responseModel, (AuthDataModel model) => model.toAuthDataEntity);
  }

  @override
  Future<ResponseEntity> getEMISLink() async{
    ResponseModel responseModel =
    (await authRemoteDataSource.getEMISLinkAction());
    return ResponseModelToEntityMapper<AuthDataEntity, AuthDataModel>()
        .toEntityFromModel(
    responseModel, (AuthDataModel model) => model.toAuthDataEntity);
  }
}
