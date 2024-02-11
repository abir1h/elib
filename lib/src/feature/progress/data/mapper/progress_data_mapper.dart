import '../../domain/entities/progress_data_entity.dart';
import '../models/progress_data_model.dart';

abstract class ProgressDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ProgressDataModelToEntityMapper
    extends ProgressDataMapper<ProgressDataModel, ProgressDataEntity> {
  @override
  ProgressDataModel fromEntityToModel(ProgressDataEntity entity) {
    return ProgressDataModel(
        bookRequests: entity.bookRequests, bookViews: entity.bookViews);
  }

  @override
  ProgressDataEntity toEntityFromModel(ProgressDataModel model) {
    return ProgressDataEntity(
      bookRequests: model.bookRequests,
      bookViews: model.bookViews,
    );
  }
}

extension ProgressDataModelExt on ProgressDataModel {
  ProgressDataEntity get toProgressDataEntity =>
      _ProgressDataModelToEntityMapper().toEntityFromModel(this);
}

extension ProgressDataEntityExt on ProgressDataEntity {
  ProgressDataModel get toProgressDataModel =>
      _ProgressDataModelToEntityMapper().fromEntityToModel(this);
}
