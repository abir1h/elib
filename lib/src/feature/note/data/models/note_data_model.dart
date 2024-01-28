import 'package:flutter/cupertino.dart';

import '../../../book/data/models/book_data_model.dart';

@immutable
class NoteDataModel {
  final int? id;
  final int bookId;
  final int emisUserId;
  final String note;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final BookDataModel? book;

  const NoteDataModel({
    this.id,
    required this.bookId,
    required this.emisUserId,
    required this.note,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.book,
  });

  factory NoteDataModel.fromJson(Map<String, dynamic> json) => NoteDataModel(
        id: json["id"] ?? -1,
        bookId: json["book_id"] ?? -1,
        emisUserId: json["emis_user_id"] ?? -21,
        note: json["note"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        book:
            json['book'] != null ? BookDataModel.fromJson(json['book']) : null,
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (id != null) {
      data["id"] = id;
    }
    data["book_id"] = bookId;
    data["emis_user_id"] = emisUserId;
    data["note"] = note;
    if (createdAt != null) {
      data["created_at"] = createdAt;
    }
    if (updatedAt != null) {
      data["updated_at"] = updatedAt;
    }
    if (deletedAt != null) {
      data["deleted_at"] = deletedAt;
    }
    return data;
  }

  static List<NoteDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, NoteDataModel>(
            json.map((x) => NoteDataModel.fromJson(x)).toList())
        : [];
  }
}
