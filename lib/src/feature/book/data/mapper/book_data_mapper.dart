import '../../../category/data/mapper/category_data_mapper.dart';
import '../../../category/data/models/category_data_model.dart';
import '../../../category/domain/entities/category_data_entity.dart';
import 'author_data_mapper.dart';
import '../models/author_data_model.dart';
import '../../domain/entities/author_data_entity.dart';
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
        titleEn: entity.titleEn,
        titleBn: entity.titleBn,
        languageEn: entity.languageEn,
        languageBn: entity.languageBn,
        editionEn: entity.editionEn,
        editionBn: entity.editionBn,
        publishYearEn: entity.publishYearEn,
        publishYearBn: entity.publishYearBn,
        publisherEn: entity.publisherEn,
        publisherBn: entity.publisherBn,
        isbnEn: entity.isbnEn,
        isbnBn: entity.isbnBn,
        slug: entity.slug,
        descriptionEn: entity.descriptionEn,
        descriptionBn: entity.descriptionBn,
        coverImage: entity.coverImage,
        bookFile: entity.bookFile,
        externalLink: entity.externalLink,
        createdBy: entity.createdBy,
        isDownload: entity.isDownload,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt,
        author: List<AuthorDataEntity>.from(entity.author)
            .map((entity) => entity.toAuthorDataModel)
            .toList(),
        category: List<CategoryDataEntity>.from(entity.category)
            .map((entity) => entity.toCategoryDataModel)
            .toList());
  }

  @override
  BookDataEntity toEntityFromModel(BookDataModel model) {
    return BookDataEntity(
        id: model.id,
        titleEn: model.titleEn,
        titleBn: model.titleBn,
        languageEn: model.languageEn,
        languageBn: model.languageBn,
        editionEn: model.editionEn,
        editionBn: model.editionBn,
        publishYearEn: model.publishYearEn,
        publishYearBn: model.publishYearBn,
        publisherEn: model.publisherEn,
        publisherBn: model.publisherBn,
        isbnEn: model.isbnEn,
        isbnBn: model.isbnBn,
        slug: model.slug,
        descriptionEn: model.descriptionEn,
        descriptionBn: model.descriptionBn,
        coverImage: model.coverImage,
        bookFile: model.bookFile,
        externalLink: model.externalLink,
        createdBy: model.createdBy,
        isDownload: model.isDownload,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt,
        author: List<AuthorDataModel>.from(model.author)
            .map((model) => model.toAuthorDataEntity)
            .toList(),
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
