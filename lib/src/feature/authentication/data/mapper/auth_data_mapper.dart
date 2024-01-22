import '../models/auth_data_model.dart';
import '../../domain/entities/auth_data_entity.dart';

abstract class AuthDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _AuthDataModelToEntityMapper
    extends AuthDataMapper<AuthDataModel, AuthDataEntity> {
  @override
  AuthDataModel fromEntityToModel(AuthDataEntity entity) {
    return AuthDataModel(
        url: entity.url,
        accessToken: entity.accessToken,
        expiresAt: entity.expiresAt,
        refreshToken: entity.refreshToken,
        role: entity.role,
        permissions: entity.permissions);
  }

  @override
  AuthDataEntity toEntityFromModel(AuthDataModel model) {
    return AuthDataEntity(
        url: model.url,
        accessToken: model.accessToken,
        expiresAt: model.expiresAt,
        refreshToken: model.refreshToken,
        role: model.role,
        permissions: model.permissions);
  }
}

extension AuthDataModelExt on AuthDataModel {
  AuthDataEntity get toAuthDataEntity =>
      _AuthDataModelToEntityMapper().toEntityFromModel(this);
}

extension AuthDataEntityExt on AuthDataEntity {
  AuthDataModel get toAuthDataModel =>
      _AuthDataModelToEntityMapper().fromEntityToModel(this);
}
