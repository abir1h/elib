import '../models/tag_data_model.dart';
import '../../domain/entities/tag_data_entity.dart';

abstract class TagDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _TagDataModelToEntityMapper
    extends TagDataMapper<TagDataModel, TagDataEntity> {
  @override
  TagDataModel fromEntityToModel(TagDataEntity entity) {
    return TagDataModel(
        id: entity.id,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn);
  }

  @override
  TagDataEntity toEntityFromModel(TagDataModel model) {
    return TagDataEntity(
        id: model.id,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt,
        nameEn: model.nameEn,
        nameBn: model.nameBn);
  }
}

extension CategoryDataModelExt on TagDataModel {
  TagDataEntity get toTagDataEntity =>
      _TagDataModelToEntityMapper().toEntityFromModel(this);
}

extension CategoryDataEntityExt on TagDataEntity {
  TagDataModel get toTagDataModel =>
      _TagDataModelToEntityMapper().fromEntityToModel(this);
}
