import 'book_data_entity.dart';

class CategoryDataEntity {
  final int id;
  final String nameEn;
  final String nameBn;
  final String image;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final List<BookDataEntity> books;

  CategoryDataEntity(
      {required this.id,
      required this.nameEn,
      required this.nameBn,
      required this.image,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.books});
}
