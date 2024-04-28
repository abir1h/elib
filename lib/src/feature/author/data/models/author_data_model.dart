import 'package:elibrary/src/feature/book/data/models/book_data_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../book/data/models/pivot_data_model.dart';
import 'author_type_data_model.dart';

@immutable
class AuthorDataModel {
  final int id;
  final int authorTypeId;
  final String nameEn;
  final String nameBn;
  final String slug;
  final String shortBioEn;
  final String shortBioBn;
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
  final BookDataModel? authorBook;

  const AuthorDataModel({
    required this.id,
    required this.authorTypeId,
    required this.nameEn,
    required this.nameBn,
    required this.slug,
    required this.shortBioBn,
    required this.shortBioEn,
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
    required this.authorBook
  });

  factory AuthorDataModel.fromJson(Map<String, dynamic> json) =>
      AuthorDataModel(
        id: json["id"] ?? -1,
        authorTypeId: json["author_type_id"] ?? -1,
        nameEn: json["name_en"] ?? "",
        nameBn: json["name_bn"] ?? "",
        slug: json["slug"] ?? "",
        shortBioBn: json["short_bio_bn"] ?? "",
        shortBioEn: json["short_bio_en"] ?? "",
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
        authorBook: json["book"] != null
            ? BookDataModel.fromJson(json["book"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author_type_id": authorTypeId,
        "name_en": nameEn,
        "name_bn": nameBn,
        "slug": slug,
        "short_bio_en": shortBioEn,
        "short_bio_bn": shortBioBn,
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
        "book": authorBook?.toJson(),
      };

  static List<AuthorDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, AuthorDataModel>(
            json.map((x) => AuthorDataModel.fromJson(x)).toList())
        : [];
  }
}
