import 'package:mindsight_admin_page/data/base_model.dart';

class NoticeBoardListModel extends BaseModel {
  List<String>? id;
  List<String>? title;
  List<String>? content;
  List<DateTime>? createdAt;
  List<DateTime>? updatedAt;
  List<int>? views;
  int? total;

  NoticeBoardListModel({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.views,
    this.total,
  });

  factory NoticeBoardListModel.fromJson(Map<String, dynamic> json) =>
      NoticeBoardListModel(
        id: json["noticeBoard"] == null
            ? []
            : List<String>.from(
                json["noticeBoard"]!.map((x) => x["id"].toString())),
        title: json["noticeBoard"] == null
            ? []
            : List<String>.from(
                json["noticeBoard"]!.map((x) => x["title"].toString())),
        content: json["noticeBoard"] == null
            ? []
            : List<String>.from(
                json["noticeBoard"]!.map((x) => x["content"].toString())),
        createdAt: json["noticeBoard"] == null
            ? []
            : List<DateTime>.from(
                json["noticeBoard"]!.map((x) => DateTime.parse(x["createdAt"])),
              ),
        updatedAt: json["noticeBoard"] == null
            ? []
            : List<DateTime>.from(
                json["noticeBoard"]!.map((x) => DateTime.parse(x["updatedAt"])),
              ),
        views: json["noticeBoard"] == null
            ? []
            : List<int>.from(
                json["noticeBoard"]!.map((x) => x["views"] as int)),
        total: json["total"],
      );
}
