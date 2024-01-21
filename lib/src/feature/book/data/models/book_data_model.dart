import 'package:flutter/foundation.dart';

import '../../../category/data/models/category_data_model.dart';

@immutable
class BookDataModel {
  final int id;
  final int adminId;
  final int categoryId;
  final int authorId;
  final String titleEn;
  final String titleBn;
  final String slug;
  final String descriptionEn;
  final String descriptionBn;
  final String coverImage;
  final String bookFile;
  final String externalLink;
  final int totalPages;
  final int totalChapters;
  final int isGenerateBook;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  // final String author;
  final CategoryDataModel? category;

  const BookDataModel({
    required this.id,
    required this.adminId,
    required this.categoryId,
    required this.authorId,
    required this.titleEn,
    required this.titleBn,
    required this.slug,
    required this.descriptionEn,
    required this.descriptionBn,
    required this.coverImage,
    required this.bookFile,
    required this.externalLink,
    required this.totalPages,
    required this.totalChapters,
    required this.isGenerateBook,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    // required this.author,
    required this.category,
  });

  factory BookDataModel.fromJson(Map<String, dynamic> json) => BookDataModel(
      id: json["id"] ?? -1,
      adminId: json["admin_id"] ?? -1,
      categoryId: json["category_id"] ?? -1,
      authorId: json["author_id"] ?? -1,
      titleEn: json["title_en"] ?? "",
      titleBn: json["title_bn"] ?? "",
      slug: json["slug"] ?? "",
      descriptionEn: json["description_en"] ?? "",
      descriptionBn: json["description_bn"] ?? "",
      coverImage: json["cover_image"] ?? "",
      bookFile: json["book_file"] ?? "",
      externalLink: json["external_link"] ?? "",
      totalPages: json["total_pages"] ?? -1,
      totalChapters: json["total_chapters"] ?? -1,
      isGenerateBook: json["is_generate_book"] ?? -1,
      status: json["status"] ?? -1,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      deletedAt: json["deleted_at"] ?? "",
      // author: json["author"] ?? '',
      category: json['category'] != null
          ? CategoryDataModel.fromJson(json['category'])
          : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin_id": adminId,
        "category_id": categoryId,
        "author_id": authorId,
        "title_en": titleEn,
        "title_bn": titleBn,
        "slug": slug,
        "description_en": descriptionEn,
        "description_bn": descriptionBn,
        "cover_image": coverImage,
        "book_file": bookFile,
        "external_link": externalLink,
        "total_pages": totalPages,
        "total_chapters": totalChapters,
        "is_generate_book": isGenerateBook,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        // "author": author,
        "category": category?.toJson(),
      };
  static List<BookDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, BookDataModel>(
            json.map((x) => BookDataModel.fromJson(x)).toList())
        : [];
  }
}
