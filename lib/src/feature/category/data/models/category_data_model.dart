import 'package:flutter/foundation.dart';

import '../../../category/data/models/book_data_model.dart';

@immutable
class CategoryDataModel {
  final int id;
  final String nameEn;
  final String nameBn;
  final String image;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final List<BookDataModel> books;

  const CategoryDataModel(
      {required this.id,
      required this.nameEn,
      required this.nameBn,
      required this.image,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.books
      });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryDataModel(
        id: json["id"] ?? -1,
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
        image: json["image"] ?? "",
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        books:  json["books"] != null ? List<BookDataModel>.from((json["books"]).map((x) => BookDataModel.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_bn": nameBn,
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
