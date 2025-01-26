import 'package:mindsight_admin_page/data/base_model.dart';

class NoticeBoardDetailModel extends BaseModel {
  String? id;
  String? title;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;

  NoticeBoardDetailModel({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory NoticeBoardDetailModel.fromJson(Map<String, dynamic> json) =>
      NoticeBoardDetailModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}
