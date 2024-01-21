import 'category_link_data_mapper.dart';
import 'category_data_mapper.dart';
import '../models/category_link_data_model.dart';
import '../models/category_data_model.dart';
import '../../domain/entities/category_link_data_enitity.dart';
import '../../domain/entities/category_data_entity.dart';
import '../../domain/entities/paginated_category_data_entity.dart';
import '../models/paginated_category_data_model.dart';

abstract class PaginatedCategoryDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _PaginatedCategoryDataModelToEntityMapper
    extends PaginatedCategoryDataMapper<PaginatedCategoryDataModel,
        PaginatedCategoryDataEntity> {
  @override
  PaginatedCategoryDataModel fromEntityToModel(
      PaginatedCategoryDataEntity entity) {
    return PaginatedCategoryDataModel(
        currentPage: entity.currentPage,
        categoryDataModel:
            List<CategoryDataEntity>.from(entity.categoryDataEntity)
                .map((entity) => entity.toCategoryDataModel)
                .toList(),
        firstPageUrl: entity.firstPageUrl,
        from: entity.from,
        lastPage: entity.lastPage,
        lastPageUrl: entity.lastPageUrl,
        links: List<CategoryLinkDataEntity>.from(entity.links)
            .map((entity) => entity.toCategoryLinkDataModel)
            .toList(),
        nextPageUrl: entity.nextPageUrl,
        path: entity.path,
        perPage: entity.perPage,
        prevPageUrl: entity.prevPageUrl,
        to: entity.to,
        total: entity.total);
  }

  @override
  PaginatedCategoryDataEntity toEntityFromModel(
      PaginatedCategoryDataModel model) {
    return PaginatedCategoryDataEntity(
        currentPage: model.currentPage,
        categoryDataEntity:
            List<CategoryDataModel>.from(model.categoryDataModel)
                .map((model) => model.toCategoryDataEntity)
                .toList(),
        firstPageUrl: model.firstPageUrl,
        from: model.from,
        lastPage: model.lastPage,
        lastPageUrl: model.lastPageUrl,
        links: List<CategoryLinkDataModel>.from(model.links)
            .map((model) => model.toCategoryLinkDataEntity)
            .toList(),
        nextPageUrl: model.nextPageUrl,
        path: model.path,
        perPage: model.perPage,
        prevPageUrl: model.prevPageUrl,
        to: model.to,
        total: model.total);
  }
}

extension CategoryBookDataModelExt on PaginatedCategoryDataModel {
  PaginatedCategoryDataEntity get toPaginatedCategoryDataEntity =>
      _PaginatedCategoryDataModelToEntityMapper().toEntityFromModel(this);
}

extension CategoryBookDataEntityExt on PaginatedCategoryDataEntity {
  PaginatedCategoryDataModel get toPaginatedCategoryDataModel =>
      _PaginatedCategoryDataModelToEntityMapper().fromEntityToModel(this);
}
