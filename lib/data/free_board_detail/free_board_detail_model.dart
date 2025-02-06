import 'package:mindsight_admin_page/data/base_model.dart';

class FreeBoardDetailModel extends BaseModel {
  String? id;
  String? title;
  String? content;
  String? attachedFile;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? masterId;
  String? masterEmail;
  String? masterNickname;
  int? views;

  FreeBoardDetailModel({
    this.id,
    this.title,
    this.content,
    this.attachedFile,
    this.createdAt,
    this.updatedAt,
    this.masterId,
    this.masterEmail,
    this.masterNickname,
    this.views,
  });

  factory FreeBoardDetailModel.fromJson(Map<String, dynamic> json) =>
      FreeBoardDetailModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        attachedFile: json["attachedFile"],
        masterId: json["masterId"],
        masterEmail: json["masterEmail"],
        masterNickname: json["masterNickname"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        views: json["views"],
      );
}
