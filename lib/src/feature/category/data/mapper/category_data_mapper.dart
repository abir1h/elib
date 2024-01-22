import '../../../book/data/mapper/pivot_data.mapper.dart';
import '../../../book/data/mapper/book_data_mapper.dart';
import '../../../book/data/models/book_data_model.dart';
import '../../../book/domain/entities/book_data_entity.dart';
import '../models/category_data_model.dart';
import '../../domain/entities/category_data_entity.dart';

abstract class CategoryDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CategoryDataModelToEntityMapper
    extends CategoryDataMapper<CategoryDataModel, CategoryDataEntity> {
  @override
  CategoryDataModel fromEntityToModel(CategoryDataEntity entity) {
    return CategoryDataModel(
        id: entity.id,
        parentId: entity.parentId,
        name: entity.name,
        nameEn: entity.nameEn,
        nameBn: entity.nameBn,
        slug: entity.slug,
        image: entity.image,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt,
        books: List<BookDataEntity>.from(entity.books)
            .map((entity) => entity.toBookDataModel)
            .toList(),
        children: List<CategoryDataEntity>.from(entity.children)
            .map((entity) => entity.toCategoryDataModel)
            .toList(),
        pivot: entity.pivot?.toPivotDataModel);
  }

  @override
  CategoryDataEntity toEntityFromModel(CategoryDataModel model) {
    return CategoryDataEntity(
        id: model.id,
        parentId: model.parentId,
        name: model.name,
        nameEn: model.nameEn,
        nameBn: model.nameBn,
        slug: model.slug,
        image: model.image,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt,
        books: List<BookDataModel>.from(model.books)
            .map((model) => model.toBookDataEntity)
            .toList(),
        children: List<CategoryDataModel>.from(model.children)
            .map((model) => model.toCategoryDataEntity)
            .toList(),
        pivot: model.pivot?.toPivotDataEntity);
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
