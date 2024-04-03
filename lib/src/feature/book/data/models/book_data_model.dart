import 'package:flutter/foundation.dart';

import '../../../author/data/models/author_data_model.dart';
import '../../../category/data/models/category_data_model.dart';
import 'tag_data_model.dart';

@immutable
class BookDataModel {
  final int id;
  final String titleEn;
  final String titleBn;
  final String languageEn;
  final String languageBn;
  final String editionEn;
  final String editionBn;
  final String publishYearEn;
  final String publishYearBn;
  final String publisherEn;
  final String publisherBn;
  final String isbnEn;
  final String isbnBn;
  final String slug;
  final String descriptionEn;
  final String descriptionBn;
  final String coverImage;
  final String bookFile;
  final String externalLink;
  final int createdBy;
  final int isDownload;
  final int status;
  final bool bookmark;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final List<AuthorDataModel> author;
  final List<CategoryDataModel> category;
  final List<TagDataModel> tag;

  const BookDataModel({
    required this.id,
    required this.titleEn,
    required this.titleBn,
    required this.languageEn,
    required this.languageBn,
    required this.editionEn,
    required this.editionBn,
    required this.publishYearEn,
    required this.publishYearBn,
    required this.publisherEn,
    required this.publisherBn,
    required this.isbnEn,
    required this.isbnBn,
    required this.slug,
    required this.descriptionEn,
    required this.descriptionBn,
    required this.coverImage,
    required this.bookFile,
    required this.externalLink,
    required this.createdBy,
    required this.isDownload,
    required this.status,
    required this.bookmark,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.author,
    required this.category,
    required this.tag,
  });

  factory BookDataModel.fromJson(Map<String, dynamic> json) => BookDataModel(
        id: json["id"] ?? -1,
        titleEn: json["title_en"] ?? "",
        titleBn: json["title_bn"] ?? "",
        languageEn: json["language_en"] ?? "",
        languageBn: json["language_bn"] ?? "",
        editionEn: json["edition_en"] ?? "",
        editionBn: json["edition_bn"] ?? "",
        publishYearEn: json["publish_year_en"] ?? "",
        publishYearBn: json["publish_year_bn"] ?? "",
        publisherEn: json["publisher_en"] ?? "",
        publisherBn: json["publisher_bn"] ?? "",
        isbnEn: json["isbn_en"] ?? "",
        isbnBn: json["isbn_bn"] ?? "",
        slug: json["slug"] ?? "",
        descriptionEn: json["description_en"] ?? "",
        descriptionBn: json["description_bn"] ?? "",
        coverImage: json["cover_image"] ?? "",
        bookFile: json["book_file"] ?? "",
        externalLink: json["external_link"] ?? "",
        createdBy: json["created_by"] ?? -1,
        isDownload: json["is_download"] ?? -1,
        status: json["status"] ?? -1,
        bookmark: json["bookmark"] ?? false,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        author: json["author"] != null
            ? List<AuthorDataModel>.from(
                (json["author"]).map((x) => AuthorDataModel.fromJson(x)))
            : [],
        category: json['category'] != null
            ? List<CategoryDataModel>.from(
                (json["category"]).map((x) => CategoryDataModel.fromJson(x)))
            : [],
        tag: json['tag'] != null
            ? List<TagDataModel>.from(
                (json["tag"]).map((x) => TagDataModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_en": titleEn,
        "title_bn": titleBn,
        "language_en": languageEn,
        "language_bn": languageBn,
        "edition_en": editionEn,
        "edition_bn": editionBn,
        "publish_year_en": publishYearEn,
        "publish_year_bn": publishYearBn,
        "publisher_en": publisherEn,
        "publisher_bn": publisherBn,
        "isbn_en": isbnEn,
        "isbn_bn": isbnBn,
        "slug": slug,
        "description_en": descriptionEn,
        "description_bn": descriptionBn,
        "cover_image": coverImage,
        "book_file": bookFile,
        "external_link": externalLink,
        "created_by": createdBy,
        "is_download": isDownload,
        "status": status,
        "bookmark": bookmark,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "tag": List<dynamic>.from(tag.map((x) => x.toJson())),
      };
  static List<BookDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, BookDataModel>(
            json.map((x) => BookDataModel.fromJson(x)).toList())
        : [];
  }
}
