import 'package:flutter/cupertino.dart';

@immutable
class BookRequestDataModel {
  final int? id;
  final int emisUserId;
  final String authorName;
  final String bookName;
  final String publishYear;
  final String edition;
  final String remark;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  BookRequestDataModel({
    this.id,
    required this.emisUserId,
    required this.authorName,
    required this.bookName,
    required this.publishYear,
    required this.edition,
    required this.remark,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory BookRequestDataModel.fromJson(Map<String, dynamic> json) => BookRequestDataModel(
    id: json["id"]??-1,
    emisUserId: json["emis_user_id"]??-1,
    authorName: json["author_name"]??"",
    bookName: json["book_name"]??"",
    publishYear: json["publish_year"]??"",
    edition: json["edition"]??"",
    remark: json["remark"]??"",
    status: json["status"]??-1,
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    deletedAt: json["deleted_at"]??"",
  );

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    if(id != null){
      data["id"] = id;
    }
    data["emis_user_id"] = emisUserId;
    data["author_name"] = authorName;
    data["book_name"] = bookName;
    data["publish_year"] = publishYear;
    data["edition"] = edition;
    data["remark"] = remark;
    if(status != null){
      data["status"] = status;
    }
    if(createdAt != null){
      data["created_at"] = createdAt;
    }
    if(updatedAt != null){
      data["updated_at"] = updatedAt;
    }
    if(deletedAt != null){
      data["deleted_at"] = deletedAt;
    }
    return data;
  }
  static List<BookRequestDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, BookRequestDataModel>(
        json.map((x) => BookRequestDataModel.fromJson(x)).toList())
        : [];
  }
}