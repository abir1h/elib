import 'package:flutter/cupertino.dart';

import '../../../book/data/models/book_data_model.dart';
@immutable
class NoteDataModel {
  final int id;
  final int bookId;
  final int emisUserId;
  final String note;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final BookDataModel? book;

  const NoteDataModel({
    required this.id,
    required this.bookId,
    required this.emisUserId,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.book,
  });

  factory NoteDataModel.fromJson(Map<String, dynamic> json) => NoteDataModel(
    id: json["id"]??-1,
    bookId: json["book_id"]??-1,
    emisUserId: json["emis_user_id"]??-21,
    note: json["note"]??"",
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    deletedAt: json["deleted_at"]??"",
    book:  json['book'] != null
        ? BookDataModel.fromJson(json['book'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "book_id": bookId,
    "emis_user_id": emisUserId,
    "note": note,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };

}