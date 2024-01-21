import '../../../book/domain/entities/book_data_entity.dart';

class CategoryDataEntity {
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
  final List<BookDataEntity> books;
  final List<CategoryDataEntity> children;

  CategoryDataEntity(
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
      required this.books,
      required this.children});
}
