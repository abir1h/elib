import '../../domain/entities/download_count_response_entity.dart';
import '../models/download_count_response_model.dart';

abstract class DownloadCountResponseMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _DownloadCountResponseModelToEntityMapper
    extends DownloadCountResponseMapper<DownloadCountResponseModel,
        DownloadCountResponseEntity> {
  @override
  DownloadCountResponseModel fromEntityToModel(
      DownloadCountResponseEntity entity) {
    return DownloadCountResponseModel(
        id: entity.id,
        bookId: entity.bookId,
        userId: entity.userId,
        downloadCount: entity.downloadCount,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt);
  }

  @override
  DownloadCountResponseEntity toEntityFromModel(
      DownloadCountResponseModel model) {
    return DownloadCountResponseEntity(
        id: model.id,
        bookId:  model.bookId,
        userId:  model.userId,
        downloadCount:  model.downloadCount,
        createdAt:  model.createdAt,
        updatedAt:  model.updatedAt);
  }
}

extension DownloadCountResponseModelExt on DownloadCountResponseModel {
  DownloadCountResponseEntity get toDownloadCountResponseEntity =>
      _DownloadCountResponseModelToEntityMapper().toEntityFromModel(this);
}

extension DownloadCountResponseEntityExt on DownloadCountResponseEntity {
  DownloadCountResponseModel get toDownloadCountResponseModel =>
      _DownloadCountResponseModelToEntityMapper().fromEntityToModel(this);
}
