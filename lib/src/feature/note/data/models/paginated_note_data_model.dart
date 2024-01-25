import 'package:flutter/foundation.dart';

import 'note_data_model.dart';

@immutable
class PaginatedNoteDataModel {
  final int currentPage;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;
  final List<NoteDataModel> noteDataModel;

  const PaginatedNoteDataModel({
    required this.currentPage,
    required this.noteDataModel,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory PaginatedNoteDataModel.fromJson(Map<String, dynamic> json) =>
      PaginatedNoteDataModel(
        currentPage: json["current_page"] ?? -1,
        firstPageUrl: json["first_page_url"] ?? "",
        from: json["from"] ?? -1,
        lastPage: json["last_page"] ?? -1,
        lastPageUrl: json["last_page_url"] ?? "",
        nextPageUrl: json["next_page_url"] ?? "",
        path: json["path"] ?? "",
        perPage: json["per_page"] ?? -1,
        prevPageUrl: json["prev_page_url"] ?? "",
        to: json["to"] ?? -1,
        total: json["total"] ?? -1,
        noteDataModel: List<NoteDataModel>.from(
            (json["data"] ?? []).map((x) => NoteDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(noteDataModel.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}
