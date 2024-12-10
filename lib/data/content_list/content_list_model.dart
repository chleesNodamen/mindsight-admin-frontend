import 'package:mindsight_admin_page/data/base_model.dart';

class ContentListModel extends BaseModel {
  List<String>? id;
  List<String>? type;
  List<String>? name;
  List<int>? seen;
  List<int>? liked;
  List<bool>? status;
  List<bool>? exposure;
  int? total;

  ContentListModel({
    this.id,
    this.type,
    this.name,
    this.seen,
    this.liked,
    this.status,
    this.exposure,
    this.total,
  });

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
            : List<int>.from(json["seen"]!.map((x) => x)),
        liked: json["liked"] == null
            ? []
            : List<int>.from(json["liked"]!.map((x) => x)),
        status: json["status"] == null
            ? []
            : List<bool>.from(json["status"]!.map((x) => x)),
        exposure: json["exposure"] == null
            ? []
            : List<bool>.from(json["exposure"]!.map((x) => x)),
        total: json["total"],
      );
}
