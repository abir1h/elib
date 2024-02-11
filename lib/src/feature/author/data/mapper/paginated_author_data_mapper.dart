import '../models/author_data_model.dart';
import 'author_data_mapper.dart';
import '../../domain/entities/author_data_entity.dart';
import '../../domain/entities/paginated_author_data_entity.dart';
import '../models/paginated_author_data_model.dart';

abstract class PaginatedAuthorDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _PaginatedAuthorDataModelToEntityMapper extends PaginatedAuthorDataMapper<
    PaginatedAuthorDataModel, PaginatedAuthorDataEntity> {
  @override
  PaginatedAuthorDataModel fromEntityToModel(PaginatedAuthorDataEntity entity) {
    return PaginatedAuthorDataModel(
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
      authorDataModel: List<AuthorDataEntity>.from(entity.authorDataEntity)
          .map((entity) => entity.toAuthorDataModel)
          .toList(),
    );
  }

  @override
  PaginatedAuthorDataEntity toEntityFromModel(PaginatedAuthorDataModel model) {
    return PaginatedAuthorDataEntity(
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
      authorDataEntity: List<AuthorDataModel>.from(model.authorDataModel)
          .map((model) => model.toAuthorDataEntity)
          .toList(),
    );
  }
}

extension PaginatedAuthorDataModelExt on PaginatedAuthorDataModel {
  PaginatedAuthorDataEntity get toPaginatedAuthorDataEntity =>
      _PaginatedAuthorDataModelToEntityMapper().toEntityFromModel(this);
}

extension PaginatedAuthorDataEntityExt on PaginatedAuthorDataEntity {
  PaginatedAuthorDataModel get toPaginatedAuthorDataModel =>
      _PaginatedAuthorDataModelToEntityMapper().fromEntityToModel(this);
}
