import 'package:mindsight_admin_page/data/base_model.dart';

class MemberListModel extends BaseModel {
  List<String>? id;
  List<String>? affiliation;
  List<String>? email;
  List<String>? username;
  List<DateTime>? createdAt;
  List<bool>? status;
  int? total;

  MemberListModel({
    this.id,
    this.affiliation,
    this.email,
    this.username,
    this.createdAt,
    this.status,
    this.total,
  });

  factory MemberListModel.fromJson(Map<String, dynamic> json) =>
      MemberListModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        affiliation: json["affiliation"] == null
            ? []
            : List<String>.from(json["affiliation"]!
                .map((x) => x == null || x == "" ? "-" : x)),
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
        username: json["username"] == null
            ? []
            : List<String>.from(json["username"]!.map((x) => x ?? "-")),
        createdAt: json["createdAt"] == null
            ? []
            : List<DateTime>.from(
                json["createdAt"]!.map((x) => DateTime.parse(x))),
        status: json["status"] == null
            ? []
            : List<bool>.from(json["status"]!.map((x) => x)),
        total: json["total"],
      );
}
