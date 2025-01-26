import 'package:mindsight_admin_page/data/base_model.dart';

class FreeBoardListModel extends BaseModel {
  List<String>? id;
  List<String>? title;
  List<String>? content;
  List<String>? masterId;
  List<String>? masterNickname;
  List<String>? masterEmail;
  List<DateTime>? createdAt;
  List<DateTime>? updatedAt;
  List<int>? views;
  List<int>? comments;
  int? total;

  FreeBoardListModel({
    this.id,
    this.title,
    this.content,
    this.masterId,
    this.masterNickname,
    this.masterEmail,
    this.createdAt,
    this.updatedAt,
    this.views,
    this.comments,
    this.total,
  });

  factory FreeBoardListModel.fromJson(Map<String, dynamic> json) =>
      FreeBoardListModel(
        id: json["freeboard"] == null
            ? []
            : List<String>.from(
                json["freeboard"]!.map((x) => x["id"].toString())),
        title: json["freeboard"] == null
            ? []
            : List<String>.from(
                json["freeboard"]!.map((x) => x["title"].toString())),
        content: json["freeboard"] == null
            ? []
            : List<String>.from(
                json["freeboard"]!.map((x) => x["content"].toString())),
        masterId: json["freeboard"] == null
            ? []
            : List<String>.from(
                json["freeboard"]!.map((x) => x["masterId"].toString())),
        masterNickname: json["freeboard"] == null
            ? []
            : List<String>.from(
                json["freeboard"]!.map((x) => x["masterNickname"].toString())),
        masterEmail: json["freeboard"] == null
            ? []
            : List<String>.from(
                json["freeboard"]!.map((x) => x["masterEmail"].toString())),
        createdAt: json["freeboard"] == null
            ? []
            : List<DateTime>.from(
                json["freeboard"]!.map((x) => DateTime.parse(x["createdAt"])),
              ),
        updatedAt: json["freeboard"] == null
            ? []
            : List<DateTime>.from(
                json["freeboard"]!.map((x) => DateTime.parse(x["updatedAt"])),
              ),
        views: json["freeboard"] == null
            ? []
            : List<int>.from(json["freeboard"]!.map((x) => x["views"] as int)),
        comments: json["freeboard"] == null
            ? []
            : List<int>.from(
                json["freeboard"]!.map((x) => x["comments"] as int)),
        total: json["total"],
      );
}
