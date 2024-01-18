import 'category_data_mapper.dart';
import '../models/category_data_model.dart';
import '../../domain/entities/category_data_entity.dart';

import '../models/book_data_model.dart';
import '../../domain/entities/book_data_entity.dart';

abstract class BookDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _BookDataModelToEntityMapper
    extends BookDataMapper<BookDataModel, BookDataEntity> {
  @override
  BookDataModel fromEntityToModel(BookDataEntity entity) {
    return BookDataModel(
        id: entity.id,
        adminId: entity.adminId,
        categoryId: entity.categoryId,
        authorId: entity.authorId,
        titleEn: entity.titleEn,
        titleBn: entity.titleBn,
        slug: entity.slug,
        descriptionEn: entity.descriptionEn,
        descriptionBn: entity.descriptionBn,
        coverImage: entity.coverImage,
        bookFile: entity.bookFile,
        externalLink: entity.externalLink,
        totalPages: entity.totalPages,
        totalChapters: entity.totalChapters,
        isGenerateBook: entity.isGenerateBook,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt,
        author: entity.author,
        category: List<CategoryDataEntity>.from(entity.category)
            .map((entity) => entity.toCategoryDataModel)
            .toList());
  }

  @override
  BookDataEntity toEntityFromModel(BookDataModel model) {
    return BookDataEntity(
        id: model.id,
        adminId: model.adminId,
        categoryId: model.categoryId,
        authorId: model.authorId,
        titleEn: model.titleEn,
        titleBn: model.titleBn,
        slug: model.slug,
        descriptionEn: model.descriptionEn,
        descriptionBn: model.descriptionBn,
        coverImage: model.coverImage,
        bookFile: model.bookFile,
        externalLink: model.externalLink,
        totalPages: model.totalPages,
        totalChapters: model.totalChapters,
        isGenerateBook: model.isGenerateBook,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt,
        author: model.author,
        category: List<CategoryDataModel>.from(model.category)
            .map((model) => model.toCategoryDataEntity)
            .toList());
  }
}

extension BookDataModelExt on BookDataModel {
  BookDataEntity get toBookDataEntity =>
      _BookDataModelToEntityMapper().toEntityFromModel(this);
}

extension BookDataEntityExt on BookDataEntity {
  BookDataModel get toBookDataModel =>
      _BookDataModelToEntityMapper().fromEntityToModel(this);
}
