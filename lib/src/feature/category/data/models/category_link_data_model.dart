import 'package:flutter/foundation.dart';

@immutable
class CategoryLinkDataModel {
  final String url;
  final String label;
  final bool active;

  const CategoryLinkDataModel({
    required this.url,
    required this.label,
    required this.active,
  });

  factory CategoryLinkDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryLinkDataModel(
        url: json["url"] ?? "",
        label: json["label"] ?? "",
        active: json["active"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
  static List<CategoryLinkDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, CategoryLinkDataModel>(
            json.map((x) => CategoryLinkDataModel.fromJson(x)).toList())
        : [];
  }
}
