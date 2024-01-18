import '../../domain/entities/category_book_data_entity.dart';
import '../models/category_book_data_model.dart';

abstract class CategoryBookDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CategoryBookDataModelToEntityMapper
    extends CategoryBookDataMapper<CategoryBookDataModel,
        CategoryBookDataEntity> {
  @override
  CategoryBookDataModel fromEntityToModel(CategoryBookDataEntity entity) {
    return CategoryBookDataModel(
        currentPage: entity.currentPage,
        categoryDataModel: entity.categoryDataModel,
        firstPageUrl: entity.firstPageUrl,
        from: entity.from,
        lastPage: entity.lastPage,
        lastPageUrl: entity.lastPageUrl,
        links: entity.links,
        nextPageUrl: entity.nextPageUrl,
        path: entity.path,
        perPage: entity.perPage,
        prevPageUrl: prevPageUrl,
        to: to,
        total: total);
  }

  @override
  CategoryBookDataEntity toEntityFromModel(CategoryBookDataModel model) {
    return CategoryBookDataEntity(
        currentPage: currentPage,
        categoryDataModel: categoryDataModel,
        firstPageUrl: firstPageUrl,
        from: from,
        lastPage: lastPage,
        lastPageUrl: lastPageUrl,
        links: links,
        nextPageUrl: nextPageUrl,
        path: path,
        perPage: perPage,
        prevPageUrl: prevPageUrl,
        to: to,
        total: total);
  }
}

extension CategoryBookDataModelExt on CategoryBookDataModel {
  CategoryBookDataEntity get toCategoryBookDataEntity =>
      _CategoryBookDataModelToEntityMapper().toEntityFromModel(this);
}

extension CategoryBookDataEntityExt on CategoryBookDataEntity {
  CategoryBookDataModel get toCategoryBookDataModel =>
      _CategoryBookDataModelToEntityMapper().fromEntityToModel(this);
}
