import 'book_request_data_mapper.dart';

import '../models/book_request_data_model.dart';
import '../../domain/entities/book_request_entity.dart';
import '../../domain/entities/paginated_book_request_data_entity.dart';
import '../models/paginated_book_request_data_model.dart';


abstract class PaginatedBookRequestRequestDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _PaginatedBookRequestDataModelToEntityMapper extends PaginatedBookRequestRequestDataMapper<
    PaginatedBookRequestDataModel, PaginatedBookRequestDataEntity> {
  @override
  PaginatedBookRequestDataModel fromEntityToModel(PaginatedBookRequestDataEntity entity) {
    return PaginatedBookRequestDataModel(
      currentPage: entity.currentPage,
      firstPageUrl: entity.firstPageUrl,
      from: entity.from,
      lastPage: entity.lastPage,
      lastPageUrl: entity.lastPageUrl,
      nextPageUrl: entity.nextPageUrl,
      path: entity.path,
      perPage: entity.perPage,
      prevPageUrl: entity.prevPageUrl,
      to: entity.to,
      total: entity.total,

      bookRequestDataModel: List<BookRequestDataEntity>.from(entity.bookRequestDataEntity)
          .map((entity) => entity.toBookRequestDataModel)
          .toList(),
    );
  }

  @override
  PaginatedBookRequestDataEntity toEntityFromModel(PaginatedBookRequestDataModel model) {
    return PaginatedBookRequestDataEntity(
      currentPage: model.currentPage,
      firstPageUrl: model.firstPageUrl,
      from: model.from,
      lastPage: model.lastPage,
      lastPageUrl: model.lastPageUrl,
      nextPageUrl: model.nextPageUrl,
      path: model.path,
      perPage: model.perPage,
      prevPageUrl: model.prevPageUrl,
      to: model.to,
      total: model.total,

      bookRequestDataEntity: List<BookRequestDataModel>.from(model.bookRequestDataModel)
          .map((model) => model.toBookRequestDataEntity)
          .toList(),
    );
  }
}

extension PaginatedBookRequestDataModelExt on PaginatedBookRequestDataModel {
  PaginatedBookRequestDataEntity get toPaginatedBookRequestDataEntity =>
      _PaginatedBookRequestDataModelToEntityMapper().toEntityFromModel(this);
}

extension PaginatedBookRequestDataEntityExt on PaginatedBookRequestDataEntity {
  PaginatedBookRequestDataModel get toPaginatedBookRequestDataModel =>
      _PaginatedBookRequestDataModelToEntityMapper().fromEntityToModel(this);
}
