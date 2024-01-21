import '../../domain/entities/author_type_data_entity.dart';
import '../models/author_type_data_model.dart';

abstract class AuthorTypeDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _AuthorTypeDataModelToEntityMapper
    extends AuthorTypeDataMapper<AuthorTypeDataModel, AuthorTypeDataEntity> {
  @override
  AuthorTypeDataModel fromEntityToModel(AuthorTypeDataEntity entity) {
    return AuthorTypeDataModel(
        id: entity.id,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt);
  }

  @override
  AuthorTypeDataEntity toEntityFromModel(AuthorTypeDataModel model) {
    return AuthorTypeDataEntity(
        id: model.id,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt);
  }
}

extension CategoryDataModelExt on AuthorTypeDataModel {
  AuthorTypeDataEntity get toAuthorTypeDataEntity =>
      _AuthorTypeDataModelToEntityMapper().toEntityFromModel(this);
}

extension CategoryDataEntityExt on AuthorTypeDataEntity {
  AuthorTypeDataModel get toAuthorTypeDataModel =>
      _AuthorTypeDataModelToEntityMapper().fromEntityToModel(this);
}
