import 'package:flutter/cupertino.dart';

@immutable
class AuthorTypeDataEntity {
  final int id;
  final String nameEn;
  final String nameBn;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  const AuthorTypeDataEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
}
