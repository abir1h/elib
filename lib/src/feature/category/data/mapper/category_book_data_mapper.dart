import 'package:elibrary/src/feature/category/data/mapper/book_link_data_mapper.dart';
import 'package:elibrary/src/feature/category/data/mapper/category_data_mapper.dart';
import 'package:elibrary/src/feature/category/data/models/book_link_data_model.dart';
import 'package:elibrary/src/feature/category/data/models/category_data_model.dart';
import 'package:elibrary/src/feature/category/domain/entities/book_link_data_enitity.dart';
import 'package:elibrary/src/feature/category/domain/entities/category_data_entity.dart';

import '../../domain/entities/category_book_data_entity.dart';
import '../models/category_book_data_model.dart';

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
            List<CategoryDataEntity>.from(entity.categoryDataModel)
                .map((entity) => entity.toCategoryDataModel)
                .toList(),
        firstPageUrl: entity.firstPageUrl,
        from: entity.from,
        lastPage: entity.lastPage,
        lastPageUrl: entity.lastPageUrl,
        links: List<BookLinkDataEntity>.from(entity.links)
            .map((entity) => entity.toBookLinkDataModel)
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
        categoryDataModel: List<CategoryDataModel>.from(model.categoryDataModel)
            .map((model) => model.toCategoryDataEntity)
            .toList(),
        firstPageUrl: model.firstPageUrl,
        from: model.from,
        lastPage: model.lastPage,
        lastPageUrl: model.lastPageUrl,
        links: List<BookLinkDataModel>.from(model.links)
            .map((model) => model.toBookDataEntity)
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
