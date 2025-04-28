import 'package:mindsight_admin_page/data/base_model.dart';

class MasterListModel extends BaseModel {
  List<String>? id;
  List<String>? companyName;
  List<String>? email;
  List<String>? nickname;
  List<DateTime>? createdAt;
  List<bool>? verified;
  int? total;

  MasterListModel({
    this.id,
    this.companyName,
    this.email,
    this.nickname,
    this.createdAt,
    this.verified,
    this.total,
  });

  MasterListModel copyWith({
    List<String>? id,
    List<String>? companyName,
    List<String>? email,
    List<String>? nickname,
    List<DateTime>? createdAt,
    List<bool>? verified,
    int? total,
  }) =>
      MasterListModel(
        id: id ?? this.id,
        companyName: companyName ?? this.companyName,
        email: email ?? this.email,
        nickname: nickname ?? this.nickname,
        createdAt: createdAt ?? this.createdAt,
        verified: verified ?? this.verified,
        total: total ?? this.total,
      );

  factory MasterListModel.fromJson(Map<String, dynamic> json) =>
      MasterListModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"].map((x) => x)),
        companyName: json["companyName"] == null
            ? []
            : List<String>.from(
                json["companyName"].map((x) => x == null || x == "" ? "" : x)),
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"].map((x) => x)),
        nickname: json["nickname"] == null
            ? []
            : List<String>.from(json["nickname"].map((x) => x ?? "")),
        createdAt: json["createdAt"] == null
            ? []
            : List<DateTime>.from(
                json["createdAt"].map((x) => DateTime.parse(x))),
        verified: json["verified"] == null
            ? []
            : List<bool>.from(json["verified"].map((x) => x)),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "companyName": companyName == null
            ? []
            : List<dynamic>.from(companyName!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "nickname":
            nickname == null ? [] : List<dynamic>.from(nickname!.map((x) => x)),
        "createdAt": createdAt == null
            ? []
            : List<dynamic>.from(createdAt!.map((x) => x.toIso8601String())),
        "verified":
            verified == null ? [] : List<dynamic>.from(verified!.map((x) => x)),
        "total": total,
      };
}
