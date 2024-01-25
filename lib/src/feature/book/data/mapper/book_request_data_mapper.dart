import '../../domain/entities/book_request_entity.dart';
import '../models/book_request_data_model.dart';

abstract class BookRequestDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class BookRequestDataModelToEntityMapper
    extends BookRequestDataMapper<BookRequestDataModel, BookRequestDataEntity> {
  @override
  BookRequestDataModel fromEntityToModel(BookRequestDataEntity entity) {
    return BookRequestDataModel(
        id: entity.id,
        emisUserId: entity.emisUserId,
        authorName: entity.authorName,
        bookName: entity.bookName,
        publishYear: entity.publishYear,
        edition: entity.edition,
        remark: entity.remark,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt);
  }

  @override
  BookRequestDataEntity toEntityFromModel(BookRequestDataModel model) {
    return BookRequestDataEntity(
        id: model.id,
        emisUserId: model.emisUserId,
        authorName: model.authorName,
        bookName: model.bookName,
        publishYear:model. publishYear,
        edition: model.edition,
        remark: model.remark,
        status: model.status,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt);
  }
}

extension BookRequestDataModelExt on BookRequestDataModel {
  BookRequestDataEntity get toBookRequestDataEntity =>
      BookRequestDataModelToEntityMapper().toEntityFromModel(this);
}

extension BookRequestDataEntityExt on BookRequestDataEntity {
  BookRequestDataModel get toBookRequestDataModel =>
      BookRequestDataModelToEntityMapper().fromEntityToModel(this);
}
