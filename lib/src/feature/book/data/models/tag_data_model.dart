import 'package:flutter/cupertino.dart';

@immutable
class TagDataModel {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String nameEn;
  final String nameBn;

  const TagDataModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.nameEn,
    required this.nameBn,
  });

  factory TagDataModel.fromJson(Map<String, dynamic> json) => TagDataModel(
        id: json["id"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "name_en": nameEn,
        "name_bn": nameBn,
      };
  static List<TagDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, TagDataModel>(
            json.map((x) => TagDataModel.fromJson(x)).toList())
        : [];
  }
}
