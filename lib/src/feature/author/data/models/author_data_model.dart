import 'package:flutter/cupertino.dart';

import '../../../book/data/models/pivot_data_model.dart';
import 'author_type_data_model.dart';

@immutable
class AuthorDataModel {
  final int id;
  final int authorTypeId;
  final String name;
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
  final PivotDataModel? pivot;
  final AuthorTypeDataModel? authorType;

  const AuthorDataModel({
    required this.id,
    required this.authorTypeId,
    required this.name,
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
    required this.pivot,
    required this.authorType,
  });

  factory AuthorDataModel.fromJson(Map<String, dynamic> json) =>
      AuthorDataModel(
        id: json["id"] ?? -1,
        authorTypeId: json["author_type_id"] ?? -1,
        name: json["name"] ?? "",
        slug: json["slug"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        address: json["address"] ?? "",
        country: json["country"] ?? "",
        photo: json["photo"] ?? "",
        status: json["status"] ?? -1,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        pivot: json["pivot"] != null
            ? PivotDataModel.fromJson(json["pivot"])
            : null,
        authorType: json["author_type"] != null
            ? AuthorTypeDataModel.fromJson(json["author_type"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author_type_id": authorTypeId,
        "name": name,
        "slug": slug,
        "email": email,
        "phone": phone,
        "address": address,
        "country": country,
        "photo": photo,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "pivot": pivot?.toJson(),
        "author_type": authorType?.toJson(),
      };

  static List<AuthorDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, AuthorDataModel>(
            json.map((x) => AuthorDataModel.fromJson(x)).toList())
        : [];
  }
}
