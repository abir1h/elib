import 'package:flutter/foundation.dart';

import '../../../book/data/models/book_data_model.dart';
import '../../../book/data/models/pivot_data_model.dart';

@immutable
class CategoryDataModel {
  final int id;
  final int parentId;
  final String name;
  final String nameEn;
  final String nameBn;
  final String slug;
  final String image;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final List<BookDataModel> book;
  final List<CategoryDataModel> children;
  final PivotDataModel? pivot;

  const CategoryDataModel(
      {required this.id,
      required this.parentId,
      required this.name,
      required this.nameEn,
      required this.nameBn,
      required this.slug,
      required this.image,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.book,
      required this.children,
      required this.pivot});

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryDataModel(
        id: json["id"] ?? -1,
        parentId: json["parent_id"] ?? -1,
        name: json["name"] ?? "",
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
        slug: json["slug"] ?? "",
        image: json["image"] ?? "",
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        book: json["book"] != null
            ? List<BookDataModel>.from(
                (json["book"]).map((x) => BookDataModel.fromJson(x)))
            : [],
        children: json["children"] != null
            ? List<CategoryDataModel>.from(
                (json["children"]).map((x) => CategoryDataModel.fromJson(x)))
            : [],
        pivot: json['pivot'] != null
            ? PivotDataModel.fromJson(json['pivot'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "name_en": nameEn,
        "name_bn": nameBn,
        "slug": slug,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
  static List<CategoryDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, CategoryDataModel>(
            json.map((x) => CategoryDataModel.fromJson(x)).toList())
        : [];
  }
}
