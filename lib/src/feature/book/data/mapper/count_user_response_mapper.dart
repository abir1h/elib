import '../../domain/entities/count_user_response_entity.dart';
import '../../domain/entities/download_count_response_entity.dart';
import '../models/count_user_response_model.dart';
import '../models/download_count_response_model.dart';
import '../../../author/data/mapper/author_type_data_mapper.dart';
import 'pivot_data.mapper.dart';
import '../../../author/domain/entities/author_data_entity.dart';
import '../../../author/data/models/author_data_model.dart';

abstract class CountUserResponseMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CountUserResponseModelToEntityMapper
    extends CountUserResponseMapper<CountUserResponseModel,
        CountUserResponseEntity> {
  @override
  CountUserResponseModel fromEntityToModel(
      CountUserResponseEntity entity) {
    return CountUserResponseModel(
        id: entity.id,
        bookId: entity.bookId,
        userId: entity.userId,
        viewCount: entity.viewCount,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt);
  }

  @override
  CountUserResponseEntity toEntityFromModel(
      CountUserResponseModel model) {
    return CountUserResponseEntity(
        id: model.id,
        bookId:  model.bookId,
        userId:  model.userId,
        viewCount:  model.viewCount,
        createdAt:  model.createdAt,
        updatedAt:  model.updatedAt);
  }
}

extension CountUserResponseModelExt on CountUserResponseModel {
  CountUserResponseEntity get toCountUserResponseEntity =>
      _CountUserResponseModelToEntityMapper().toEntityFromModel(this);
}

extension CountUserResponseEntityExt on CountUserResponseEntity {
  CountUserResponseModel get toCountUserResponseModel =>
      _CountUserResponseModelToEntityMapper().fromEntityToModel(this);
}
