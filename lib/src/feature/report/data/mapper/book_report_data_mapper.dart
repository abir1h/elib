import '../../../book/data/mapper/book_data_mapper.dart';
import '../../domain/entities/book_report_data_entity.dart';
import '../models/book_report_data_model.dart';

abstract class BookReportDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _BookReportDataModelToEntityMapper
    extends BookReportDataMapper<BookReportDataModel,
        BookReportDataEntity> {
  @override
  BookReportDataModel fromEntityToModel(
      BookReportDataEntity entity) {
    return BookReportDataModel(
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
  BookReportDataEntity toEntityFromModel(
      BookReportDataModel model) {
    return BookReportDataEntity(
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

extension BookReportDataModelExt on BookReportDataModel {
  BookReportDataEntity get toBookReportDataEntity =>
      _BookReportDataModelToEntityMapper().toEntityFromModel(this);
}

extension BookViewDownloadDataEntityExt on BookReportDataEntity {
  BookReportDataModel get toBookReportDataModel =>
      _BookReportDataModelToEntityMapper().fromEntityToModel(this);
}
