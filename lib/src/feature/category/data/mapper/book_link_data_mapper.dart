import '../models/book_link_data_model.dart';
import '../../domain/entities/book_link_data_enitity.dart';

abstract class BookLinkDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);

}

class _BookLinkDataModelToEntityMapper
    extends BookLinkDataMapper<BookLinkDataModel, BookLinkDataEntity> {


  @override
  BookLinkDataModel fromEntityToModel(BookLinkDataEntity entity) {
    return BookLinkDataModel(
        url: entity.url, label: entity.label, active: entity.active);
  }

  @override
  BookLinkDataEntity toEntityFromModel(BookLinkDataModel model) {
    return BookLinkDataEntity(
        url: model.url, label: model.label, active: model.active);
  }
}

extension BookLinkDataModelExt on BookLinkDataModel {
  BookLinkDataEntity get toBookDataEntity =>
      _BookLinkDataModelToEntityMapper().toEntityFromModel(this);
}

extension BookLinkDataEntityExt on BookLinkDataEntity {
  BookLinkDataModel get toBookLinkDataModel =>
      _BookLinkDataModelToEntityMapper().fromEntityToModel(this);
}
