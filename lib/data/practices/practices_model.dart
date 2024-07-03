import 'package:mindsight_admin_page/data/base_model.dart';

class PracticesModel extends BaseModel {
  List<String>? id;
  List<int>? level;
  List<int>? finished;
  List<int>? participated;
  List<String>? ratio;
  List<int>? liked;
  List<int>? total;

  PracticesModel({
    this.id,
    this.level,
    this.finished,
    this.participated,
    this.ratio,
    this.liked,
    this.total,
  });

  PracticesModel copyWith({
    List<String>? id,
    List<int>? level,
    List<int>? finished,
    List<int>? participated,
    List<String>? ratio,
    List<int>? liked,
    List<int>? total,
  }) =>
      PracticesModel(
          id: id ?? this.id,
          level: level ?? this.level,
          finished: finished ?? this.finished,
          participated: participated ?? this.participated,
          ratio: ratio ?? this.ratio,
          liked: liked ?? this.liked,
          total: total ?? this.total);

  factory PracticesModel.fromJson(Map<String, dynamic> json) => PracticesModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
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
        total: json["total"] == null
            ? []
            : List<int>.from(json["total"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "level": level == null ? [] : List<dynamic>.from(level!.map((x) => x)),
        "finished":
            finished == null ? [] : List<dynamic>.from(finished!.map((x) => x)),
        "participated": participated == null
            ? []
            : List<dynamic>.from(participated!.map((x) => x)),
        "ratio": ratio == null ? [] : List<dynamic>.from(ratio!.map((x) => x)),
        "liked": liked == null ? [] : List<dynamic>.from(liked!.map((x) => x)),
        "total": total == null ? [] : List<dynamic>.from(total!.map((x) => x)),
      };
}
