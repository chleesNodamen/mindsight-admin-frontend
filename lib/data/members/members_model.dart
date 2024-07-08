import 'package:mindsight_admin_page/data/base_model.dart';

class MembersModel extends BaseModel {
  List<String>? id;
  List<String>? affiliation;
  List<String>? email;
  List<String>? username;
  List<DateTime>? createdAt;
  List<bool>? status;
  int? total;

  MembersModel({
    this.id,
    this.affiliation,
    this.email,
    this.username,
    this.createdAt,
    this.status,
    this.total,
  });

  MembersModel copyWith({
    List<String>? id,
    List<String>? affiliation,
    List<String>? email,
    List<String>? username,
    List<DateTime>? createdAt,
    List<bool>? status,
    int? total,
  }) =>
      MembersModel(
        id: id ?? this.id,
        affiliation: affiliation ?? this.affiliation,
        email: email ?? this.email,
        username: username ?? this.username,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        total: total ?? this.total,
      );

  factory MembersModel.fromJson(Map<String, dynamic> json) => MembersModel(
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

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "affiliation": affiliation == null
            ? []
            : List<dynamic>.from(affiliation!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "username":
            username == null ? [] : List<dynamic>.from(username!.map((x) => x)),
        "createdAt": createdAt == null
            ? []
            : List<dynamic>.from(createdAt!.map((x) => x.toIso8601String())),
        "status":
            status == null ? [] : List<dynamic>.from(status!.map((x) => x)),
        "total": total,
      };
}
