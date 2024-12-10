import 'package:mindsight_admin_page/data/base_model.dart';

class PracticeListModel extends BaseModel {
  List<String>? id;
  List<String>? name;
  List<int>? level;
  List<int>? finished;
  List<int>? participated;
  List<String>? ratio;
  List<int>? liked;
  List<String>? masterId;
  List<String>? masterName;
  List<bool>? status;
  List<bool>? exposure;
  int? total;

  PracticeListModel({
    this.id,
    this.name,
    this.level,
    this.finished,
    this.participated,
    this.ratio,
    this.liked,
    this.masterId,
    this.masterName,
    this.status,
    this.exposure,
    this.total,
  });

  factory PracticeListModel.fromJson(Map<String, dynamic> json) =>
      PracticeListModel(
          id: json["id"] == null
              ? []
              : List<String>.from(json["id"]!.map((x) => x)),
          name: json["name"] == null
              ? []
              : List<String>.from(json["name"]!.map((x) => x)),
          level: json["level"] == null
              ? []
              : List<int>.from(json["level"]!.map((x) => x)),
          finished: json["finished"] == null
              ? []
              : List<int>.from(json["finished"]!.map((x) => x)),
          participated: json["participated"] == null
              ? []
              : List<int>.from(json["participated"]!.map((x) => x)),
          ratio: json["ratio"] == null
              ? []
              : List<String>.from(json["ratio"]!.map((x) => x)),
          liked: json["liked"] == null
              ? []
              : List<int>.from(json["liked"].map((x) => x)),
          masterId: json["masterId"] == null
              ? []
              : List<String>.from(json["masterId"]!.map((x) => x)),
          masterName: json["masterName"] == null
              ? []
              : List<String>.from(json["masterName"]!.map((x) => x)),
          status: json["status"] == null
              ? []
              : List<bool>.from(json["status"]!.map((x) => x)),
          exposure: json["exposure"] == null
              ? []
              : List<bool>.from(json["exposure"]!.map((x) => x)),
          total: json["total"]);
}
