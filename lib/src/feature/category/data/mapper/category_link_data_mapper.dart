import '../models/category_link_data_model.dart';
import '../../domain/entities/category_link_data_enitity.dart';

abstract class CategoryLinkDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);

}

class _CategoryLinkDataModelToEntityMapper
    extends CategoryLinkDataMapper<CategoryLinkDataModel, CategoryLinkDataEntity> {


  @override
  CategoryLinkDataModel fromEntityToModel(CategoryLinkDataEntity entity) {
    return CategoryLinkDataModel(
        url: entity.url, label: entity.label, active: entity.active);
  }

  @override
  CategoryLinkDataEntity toEntityFromModel(CategoryLinkDataModel model) {
    return CategoryLinkDataEntity(
        url: model.url, label: model.label, active: model.active);
  }
}

extension BookLinkDataModelExt on CategoryLinkDataModel {
  CategoryLinkDataEntity get toCategoryLinkDataEntity =>
      _CategoryLinkDataModelToEntityMapper().toEntityFromModel(this);
}

extension BookLinkDataEntityExt on CategoryLinkDataEntity {
  CategoryLinkDataModel get toCategoryLinkDataModel =>
      _CategoryLinkDataModelToEntityMapper().fromEntityToModel(this);
}
