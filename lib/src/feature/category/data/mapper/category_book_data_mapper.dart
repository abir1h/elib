import 'category_link_data_mapper.dart';
import 'category_data_mapper.dart';
import '../models/category_link_data_model.dart';
import '../models/category_data_model.dart';
import '../../domain/entities/category_link_data_enitity.dart';
import '../../domain/entities/category_data_entity.dart';
import '../../domain/entities/category_book_data_entity.dart';
import '../models/category_book_data_model.dart';
import '../../../book/data/mapper/book_data_mapper.dart';
import '../../../book/data/models/book_data_model.dart';
import '../../../book/domain/entities/book_data_entity.dart';

abstract class CategoryBookDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CategoryBookDataModelToEntityMapper extends CategoryBookDataMapper<
    CategoryBookDataModel, CategoryBookDataEntity> {
  @override
  CategoryBookDataModel fromEntityToModel(CategoryBookDataEntity entity) {
    return CategoryBookDataModel(
        currentPage: entity.currentPage,
        categoryDataModel:
            List<CategoryDataEntity>.from(entity.categoryDataEntity)
                .map((entity) => entity.toCategoryDataModel)
                .toList(),
        bookDataModel: List<BookDataEntity>.from(entity.bookDataEntity)
            .map((entity) => entity.toBookDataModel)
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
  CategoryBookDataEntity toEntityFromModel(CategoryBookDataModel model) {
    return CategoryBookDataEntity(
        currentPage: model.currentPage,
        categoryDataEntity:
            List<CategoryDataModel>.from(model.categoryDataModel)
                .map((model) => model.toCategoryDataEntity)
                .toList(),
        bookDataEntity: List<BookDataModel>.from(model.bookDataModel)
            .map((model) => model.toBookDataEntity)
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

extension CategoryBookDataModelExt on CategoryBookDataModel {
  CategoryBookDataEntity get toCategoryBookDataEntity =>
      _CategoryBookDataModelToEntityMapper().toEntityFromModel(this);
}

extension CategoryBookDataEntityExt on CategoryBookDataEntity {
  CategoryBookDataModel get toCategoryBookDataModel =>
      _CategoryBookDataModelToEntityMapper().fromEntityToModel(this);
}
