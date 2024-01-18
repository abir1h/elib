import 'package:flutter/foundation.dart';

@immutable
class BookLinkDataModel {
  final String url;
  final String label;
  final bool active;

  BookLinkDataModel({
    required this.url,
    required this.label,
    required this.active,
  });

  factory BookLinkDataModel.fromJson(Map<String, dynamic> json) =>
      BookLinkDataModel(
        url: json["url"] ?? "",
        label: json["label"] ?? "",
        active: json["active"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
  static List<BookLinkDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, BookLinkDataModel>(
            json.map((x) => BookLinkDataModel.fromJson(x)).toList())
        : [];
  }
}
