import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/data/base_model.dart';

class MembersModel extends BaseModel {
  List<String>? id;
  List<String>? affiliation;
  List<String>? email;
  List<String>? username;
  List<String>? createdAt;
  List<String>? status;
  int? number;

  MembersModel({
    this.id,
    this.affiliation,
    this.email,
    this.username,
    this.createdAt,
    this.status,
    this.number,
  });

  MembersModel copyWith({
    List<String>? id,
    List<String>? affiliation,
    List<String>? email,
    List<String>? username,
    List<String>? createdAt,
    List<String>? status,
    int? number,
  }) =>
      MembersModel(
        id: id ?? this.id,
        affiliation: affiliation ?? this.affiliation,
        email: email ?? this.email,
        username: username ?? this.username,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        number: number ?? this.number,
      );

  factory MembersModel.fromJson(Map<String, dynamic> json) => MembersModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        affiliation: json["affiliation"] == null
            ? []
            : List<String>.from(json["affiliation"]!.map((x) => x)),
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
        username: json["username"] == null
            ? []
            : List<String>.from(json["username"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? []
            : List<String>.from(json["createdAt"]!.map(
                (x) => DateFormat('yyyy-MM-dd').format(DateTime.parse(x)))),
        status: json["status"] == null
            ? []
            : List<String>.from(json["status"]!.map((x) => x)),
        number: json["number"],
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
            : List<dynamic>.from(createdAt!.map((x) => x)),
        "status":
            status == null ? [] : List<dynamic>.from(status!.map((x) => x)),
        "number": number,
      };
}
