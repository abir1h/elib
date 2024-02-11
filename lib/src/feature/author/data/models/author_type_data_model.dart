import 'package:flutter/cupertino.dart';

@immutable
class AuthorTypeDataModel {
  final int id;
  final String nameEn;
  final String nameBn;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  const AuthorTypeDataModel({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory AuthorTypeDataModel.fromJson(Map<String, dynamic> json) =>
      AuthorTypeDataModel(
        id: json["id"] ?? -1,
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_bn": nameBn,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
