import '../../domain/entities/pivot_data_entity.dart';
import '../models/pivot_data_model.dart';

abstract class PivotDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _PivotDataModelToEntityMapper
    extends PivotDataMapper<PivotDataModel, PivotDataEntity> {
  @override
  PivotDataModel fromEntityToModel(PivotDataEntity entity) {
    return PivotDataModel(bookId: entity.bookId, categoryId: entity.categoryId);
  }

  @override
  PivotDataEntity toEntityFromModel(PivotDataModel model) {
    return PivotDataEntity(bookId: model.bookId, categoryId: model.categoryId);
  }
}

extension CategoryDataModelExt on PivotDataModel {
  PivotDataEntity get toPivotDataEntity =>
      _PivotDataModelToEntityMapper().toEntityFromModel(this);
}

extension CategoryDataEntityExt on PivotDataEntity {
  PivotDataModel get toPivotDataModel =>
      _PivotDataModelToEntityMapper().fromEntityToModel(this);
}
