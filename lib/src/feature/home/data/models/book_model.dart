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

  BookDataModel({
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
  });

  factory BookDataModel.fromJson(Map<String, dynamic> json) => BookDataModel(
    id: json["id"]??0,
    adminId: json["admin_id"]??0,
    categoryId: json["category_id"]??0,
    authorId: json["author_id"]??0,
    titleEn: json["title_en"]??"",
    titleBn: json["title_bn"]??"",
    slug: json["slug"]??"",
    descriptionEn: json["description_en"]??"",
    descriptionBn: json["description_bn"]??"",
    coverImage: json["cover_image"]??"",
    bookFile: json["book_file"]??"",
    externalLink: json["external_link"]??"",
    totalPages: json["total_pages"]??0,
    totalChapters: json["total_chapters"]??0,
    isGenerateBook: json["is_generate_book"]??0,
    status: json["status"]??0,
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    deletedAt: json["deleted_at"]??"",
  );

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
  };
}