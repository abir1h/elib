import 'package:elibrary/src/feature/book/data/mapper/book_data_mapper.dart';
import 'package:elibrary/src/feature/book/data/models/book_data_model.dart';
import 'package:elibrary/src/feature/book/domain/entities/book_data_entity.dart';

import 'author_type_data_mapper.dart';
import '../../../book/data/mapper/pivot_data.mapper.dart';
import '../../domain/entities/author_data_entity.dart';
import '../models/author_data_model.dart';

abstract class AuthorDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _AuthorDataModelToEntityMapper
    extends AuthorDataMapper<AuthorDataModel, AuthorDataEntity> {
  @override
  AuthorDataModel fromEntityToModel(AuthorDataEntity entity) {
    return AuthorDataModel(
      id: entity.id,
      authorTypeId: entity.authorTypeId,
      nameEn: entity.nameEn,
      nameBn: entity.nameBn,
      slug: entity.slug,
      shortBioBn: entity.shortBioBn,
      shortBioEn: entity.shortBioEn,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      country: entity.country,
      photo: entity.photo,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
      pivot: entity.pivot?.toPivotDataModel,
      authorType: entity.authorType?.toAuthorTypeDataModel,
      authorBook: List<BookDataEntity>.from(entity.authorBook!)
          .map((entity) => entity.toBookDataModel)
          .toList(),
    );
  }

  @override
  AuthorDataEntity toEntityFromModel(AuthorDataModel model) {
    return AuthorDataEntity(
      id: model.id,
      authorTypeId: model.authorTypeId,
      nameEn: model.nameEn,
      nameBn: model.nameBn,
      slug: model.slug,
      shortBioEn: model.shortBioEn,
      shortBioBn: model.shortBioBn,
      email: model.email,
      phone: model.phone,
      address: model.address,
      country: model.country,
      photo: model.photo,
      status: model.status,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      deletedAt: model.deletedAt,
      pivot: model.pivot?.toPivotDataEntity,
      authorType: model.authorType?.toAuthorTypeDataEntity,
      authorBook: List<BookDataModel>.from(model.authorBook!)
          .map((model) => model.toBookDataEntity)
          .toList(),
    );
  }
}

extension AuthorDataModelExt on AuthorDataModel {
  AuthorDataEntity get toAuthorDataEntity =>
      _AuthorDataModelToEntityMapper().toEntityFromModel(this);
}

extension AuthorDataEntityExt on AuthorDataEntity {
  AuthorDataModel get toAuthorDataModel =>
      _AuthorDataModelToEntityMapper().fromEntityToModel(this);
}
