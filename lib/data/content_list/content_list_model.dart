import 'package:mindsight_admin_page/data/base_model.dart';

class ContentListModel extends BaseModel {
  List<String>? id;
  List<String>? type;
  List<String>? name;
  List<int>? seen;
  List<int>? liked;
  List<bool>? status;
  int? total;

  ContentListModel({
    this.id,
    this.type,
    this.name,
    this.seen,
    this.liked,
    this.status,
    this.total,
  });

  ContentListModel copyWith({
    List<String>? id,
    List<String>? type,
    List<String>? name,
    List<int>? seen,
    List<int>? liked,
    List<bool>? status,
    int? total,
  }) =>
      ContentListModel(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        seen: seen ?? this.seen,
        liked: liked ?? this.liked,
        status: status ?? this.status,
        total: total ?? this.total,
      );

  factory ContentListModel.fromJson(Map<String, dynamic> json) =>
      ContentListModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        type: json["type"] == null
            ? []
            : List<String>.from(
                json["type"]!.map((x) => x == null || x == "" ? "-" : x)),
        name: json["name"] == null
            ? []
            : List<String>.from(json["name"]!.map((x) => x)),
        seen: json["seen"] == null
            ? []
            : List<int>.from(json["seen"]!.map((x) => x ?? "-")),
        liked: json["liked"] == null
            ? []
            : List<int>.from(json["liked"]!.map((x) => int.parse(x))),
        status: json["status"] == null
            ? []
            : List<bool>.from(json["status"]!.map((x) => x)),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
        "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
        "seen": seen == null ? [] : List<dynamic>.from(seen!.map((x) => x)),
        "liked": liked == null ? [] : List<dynamic>.from(liked!.map((x) => x)),
        "status":
            status == null ? [] : List<dynamic>.from(status!.map((x) => x)),
        "total": total,
      };
}
