import 'package:mindsight_admin_page/data/base_model.dart';

class FreeBoardCommentListModel extends BaseModel {
  List<CommentModel>? comments;
  int? total;

  FreeBoardCommentListModel({
    this.comments,
    this.total,
  });

  factory FreeBoardCommentListModel.fromJson(Map<String, dynamic> json) =>
      FreeBoardCommentListModel(
        comments: json["comments"] == null
            ? []
            : List<CommentModel>.from(
                json["comments"]!.map((x) => CommentModel.fromJson(x))),
        total: json["total"],
      );
}

class CommentModel {
  String? id;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? masterId;
  String? masterNickname;
  String? masterEmail;

  CommentModel({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.masterId,
    this.masterNickname,
    this.masterEmail,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"]?.toString(),
        content: json["content"]?.toString(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        masterId: json["masterId"]?.toString(),
        masterNickname: json["masterNickname"]?.toString(),
        masterEmail: json["masterEmail"]?.toString(),
      );
}
