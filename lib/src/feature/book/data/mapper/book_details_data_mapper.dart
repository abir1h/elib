import '../../../author/data/models/author_data_model.dart';
import '../../../category/data/models/category_data_model.dart';
import '../../../category/data/mapper/category_data_mapper.dart';
import '../../../author/data/mapper/author_data_mapper.dart';
import '../../../category/domain/entities/category_data_entity.dart';
import 'book_data_mapper.dart';
import '../../../author/domain/entities/author_data_entity.dart';
import '../../domain/entities/book_details_data_entity.dart';
import '../models/book_details_data_model.dart';

abstract class BookDetailsDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _BookDetailsDataModelToEntityMapper
    extends BookDetailsDataMapper<BookDetailsDataModel, BookDetailsDataEntity> {
  @override
  BookDetailsDataModel fromEntityToModel(BookDetailsDataEntity entity) {
    return BookDetailsDataModel(
      bookDetails: entity.bookDetails.toBookDataModel,
      authorBook: List<AuthorDataEntity>.from(entity.authorBook!)
          .map((entity) => entity.toAuthorDataModel)
          .toList(),
      categoryBook: List<CategoryDataEntity>.from(entity.categoryBook!)
          .map((entity) => entity.toCategoryDataModel)
          .toList(),
    );
  }

  @override
  BookDetailsDataEntity toEntityFromModel(BookDetailsDataModel model) {
    return BookDetailsDataEntity(
      bookDetails: model.bookDetails!.toBookDataEntity,
      authorBook: List<AuthorDataModel>.from(model.authorBook)
          .map((model) => model.toAuthorDataEntity)
          .toList(),
      categoryBook: List<CategoryDataModel>.from(model.categoryBook)
          .map((model) => model.toCategoryDataEntity)
          .toList(),
    );
  }
}

extension BookDetailsDataModelExt on BookDetailsDataModel {
  BookDetailsDataEntity get toBookDetailsDataEntity =>
      _BookDetailsDataModelToEntityMapper().toEntityFromModel(this);
}

extension BookDetailsDataEntityExt on BookDetailsDataEntity {
  BookDetailsDataModel get toBookDetailsDataModel =>
      _BookDetailsDataModelToEntityMapper().fromEntityToModel(this);
}
