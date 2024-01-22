import '../../../category/data/models/category_data_model.dart';
import '../../../category/domain/entities/category_data_entity.dart';
import '../../data/models/author_data_model.dart';
import 'author_data_entity.dart';

class BookDataEntity {
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
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final List<AuthorDataEntity> author;
  final List<CategoryDataEntity> category;

  const BookDataEntity({
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
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.author,
    required this.category,
  });
}
