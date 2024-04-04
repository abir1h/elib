import 'package:flutter/cupertino.dart';

import '../../../book/domain/entities/pivot_data_entity.dart';
import 'author_type_data_entity.dart';

@immutable
class AuthorDataEntity {
  final int id;
  final int authorTypeId;
  final String nameEn;
  final String nameBn;
  final String slug;
  final String email;
  final String phone;
  final String address;
  final String country;
  final String photo;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final PivotDataEntity? pivot;
  final AuthorTypeDataEntity? authorType;

  const AuthorDataEntity({
    required this.id,
    required this.authorTypeId,
    required this.nameEn,
    required this.nameBn,
    required this.slug,
    required this.email,
    required this.phone,
    required this.address,
    required this.country,
    required this.photo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    this.pivot,
    this.authorType,
  });
}
