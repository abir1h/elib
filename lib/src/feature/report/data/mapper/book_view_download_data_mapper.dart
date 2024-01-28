import '../../../book/data/mapper/book_data_mapper.dart';
import '../../domain/entities/book_view_download_data_entity.dart';
import '../models/book_view_download_data_model.dart';

abstract class BookViewDownloadDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _BookViewDownloadDataModelToEntityMapper
    extends BookViewDownloadDataMapper<BookViewDownloadDataModel,
        BookViewDownloadDataEntity> {
  @override
  BookViewDownloadDataModel fromEntityToModel(
      BookViewDownloadDataEntity entity) {
    return BookViewDownloadDataModel(
        id: entity.id,
        bookId: entity.bookId,
        userId: entity.userId,
        viewCount: entity.viewCount,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        bookDownload: entity.bookDownload,
        book: entity.book?.toBookDataModel);
  }

  @override
  BookViewDownloadDataEntity toEntityFromModel(
      BookViewDownloadDataModel model) {
    return BookViewDownloadDataEntity(
        id: model.id,
        bookId: model.bookId,
        userId: model.userId,
        viewCount: model.viewCount,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        bookDownload: model.bookDownload,
        book: model.book?.toBookDataEntity);
  }
}

extension BookViewDownloadDataModelExt on BookViewDownloadDataModel {
  BookViewDownloadDataEntity get toBookViewDownloadDataEntity =>
      _BookViewDownloadDataModelToEntityMapper().toEntityFromModel(this);
}

extension BookViewDownloadDataEntityExt on BookViewDownloadDataEntity {
  BookViewDownloadDataModel get toBookViewDownloadDataModel =>
      _BookViewDownloadDataModelToEntityMapper().fromEntityToModel(this);
}
