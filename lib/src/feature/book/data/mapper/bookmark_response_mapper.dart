import '../models/bookmark_response_model.dart';
import '../../domain/entities/bookmark_response_entity.dart';

abstract class BookmarkMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _BookmarResponseModelToEntityMapper
    extends BookmarkMapper<BookmarkResponseModel, BookmarkResponseEntity> {
  @override
  BookmarkResponseModel fromEntityToModel(BookmarkResponseEntity entity) {
    return BookmarkResponseModel(
        emisUserId: entity.emisUserId,
        bookId: entity.bookId,
        updatedAt: entity.updatedAt,
        createdAt: entity.createdAt,
        id: entity.id,
        status: entity.status);
  }

  @override
  BookmarkResponseEntity toEntityFromModel(BookmarkResponseModel model) {
    return BookmarkResponseEntity(
        emisUserId: model.emisUserId,
        bookId: model.bookId,
        updatedAt: model.updatedAt,
        createdAt: model.createdAt,
        id: model.id,
        status: model.status);
  }
}

extension BookmarkResponseModelExt on BookmarkResponseModel {
  BookmarkResponseEntity get toBookmarkResponseEntity =>
      _BookmarResponseModelToEntityMapper().toEntityFromModel(this);
}

extension BookmarkResponseEntityExt on BookmarkResponseEntity {
  BookmarkResponseModel get toBookmarkResponseModel =>
      _BookmarResponseModelToEntityMapper().fromEntityToModel(this);
}
