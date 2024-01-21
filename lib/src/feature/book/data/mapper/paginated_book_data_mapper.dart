import 'book_data_mapper.dart';
import '../../../category/data/mapper/category_link_data_mapper.dart';
import '../../../category/data/models/category_link_data_model.dart';
import '../../../category/domain/entities/category_link_data_enitity.dart';
import '../../domain/entities/book_data_entity.dart';
import '../../domain/entities/paginated_book_data_entity.dart';
import '../models/book_data_model.dart';
import '../models/paginated_book_data_model.dart';

abstract class PaginatedBookDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _PaginatedBookDataModelToEntityMapper extends PaginatedBookDataMapper<
    PaginatedBookDataModel, PaginatedBookDataEntity> {
  @override
  PaginatedBookDataModel fromEntityToModel(PaginatedBookDataEntity entity) {
    return PaginatedBookDataModel(
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
      links: List<CategoryLinkDataEntity>.from(entity.links)
          .map((entity) => entity.toCategoryLinkDataModel)
          .toList(),
      bookDataModel: List<BookDataEntity>.from(entity.bookDataEntity)
          .map((entity) => entity.toBookDataModel)
          .toList(),
    );
  }

  @override
  PaginatedBookDataEntity toEntityFromModel(PaginatedBookDataModel model) {
    return PaginatedBookDataEntity(
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
      links: List<CategoryLinkDataModel>.from(model.links)
          .map((model) => model.toCategoryLinkDataEntity)
          .toList(),
      bookDataEntity: List<BookDataModel>.from(model.bookDataModel)
          .map((model) => model.toBookDataEntity)
          .toList(),
    );
  }
}

extension CategoryBookDataModelExt on PaginatedBookDataModel {
  PaginatedBookDataEntity get toPaginatedBookDataEntity =>
      _PaginatedBookDataModelToEntityMapper().toEntityFromModel(this);
}

extension CategoryBookDataEntityExt on PaginatedBookDataEntity {
  PaginatedBookDataModel get toPaginatedBookDataModel =>
      _PaginatedBookDataModelToEntityMapper().fromEntityToModel(this);
}
