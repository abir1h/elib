import 'package:elibrary/src/feature/book/data/mapper/book_data_mapper.dart';
import 'package:elibrary/src/feature/book/data/models/book_data_model.dart';

import '../../domain/entities/bookmark_data_entity.dart';
import '../models/bookmark_data_model.dart';
import '../../domain/entities/bookmark_response_entity.dart';

abstract class BookmarkDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class BookmarkDataModelToEntityMapper
    extends BookmarkDataMapper<BookmarkDataModel, BookmarkDataEntity> {
  @override
  BookmarkDataModel fromEntityToModel(BookmarkDataEntity entity) {
    return BookmarkDataModel(
      id: entity.id,
      bookId: entity.bookId,
      emisUserId: entity.emisUserId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
      status: entity.status,
      book: entity.book?.toBookDataModel,
    );
  }

  @override
  BookmarkDataEntity toEntityFromModel(BookmarkDataModel model) {
    return BookmarkDataEntity(
        id: model.id,
        bookId: model.bookId,
        emisUserId: model.emisUserId,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt,
        status: model.status,
        book: model.book?.toBookDataEntity);
  }
}

extension BookmarkDataModelExt on BookmarkDataModel {
  BookmarkDataEntity get toBookmarkDataEntity =>
      BookmarkDataModelToEntityMapper().toEntityFromModel(this);
}

extension BookmarkDataEntityExt on BookmarkDataEntity {
  BookmarkDataModel get toBookmarkDataModel =>
      BookmarkDataModelToEntityMapper().fromEntityToModel(this);
}
