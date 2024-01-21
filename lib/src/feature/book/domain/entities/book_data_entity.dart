import '../../../category/domain/entities/category_data_entity.dart';

class BookDataEntity {
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
  final String author;
  final CategoryDataEntity? category;
  BookDataEntity({
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
    required this.author,
    required this.category,
  });
}
