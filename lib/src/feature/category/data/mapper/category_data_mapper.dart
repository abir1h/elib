import 'package:elibrary/src/feature/category/data/models/category_data_model.dart';

import '../../domain/entities/category_book_data_entity.dart';
import '../../domain/entities/category_data_entity.dart';
import '../models/category_book_data_model.dart';

abstract class CategoryDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class  _CategoryDataModelToEntityMapper
    extends CategoryDataMapper<CategoryDataModel, CategoryDataEntity> {
  @override
  CategoryDataModel fromEntityToModel(CategoryDataEntity entity) {
    return CategoryDataModel(
        id: entity.id,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        image: entity.image,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt,
        books: entity.books);
  }

  @override
  CategoryDataEntity toEntityFromModel(CategoryDataModel model) {
    return CategoryDataEntity(
        id: model.id,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        image: model.image,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt,
        books: model.books);
  }
}

extension CategoryDataModelExt on CategoryDataModel {
  CategoryDataEntity get toCategoryDataEntity =>
       _CategoryDataModelToEntityMapper().toEntityFromModel(this);
}

extension CategoryDataEntityExt on CategoryDataEntity {
  CategoryDataModel get toCategoryDataModel =>
       _CategoryDataModelToEntityMapper().fromEntityToModel(this);
}
