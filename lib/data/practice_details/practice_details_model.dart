import 'package:mindsight_admin_page/data/base_model.dart';

class PracticeDetailsModel extends BaseModel {
  String? id;
  String? level;
  String? body;
  String? breath;
  int? finished;
  int? participated;
  String? ratio;
  int? liked;

  PracticeDetailsModel(
      {this.id,
      this.level,
      this.body,
      this.breath,
      this.finished,
      this.participated,
      this.ratio,
      this.liked});

  PracticeDetailsModel copyWith(
          {String? id,
          String? level,
          String? body,
          String? breath,
          int? finished,
          int? participated,
          String? ratio,
          int? liked}) =>
      PracticeDetailsModel(
        id: id ?? this.id,
        level: level ?? this.level,
        body: body ?? this.body,
        breath: breath ?? this.breath,
        finished: finished ?? this.finished,
        participated: participated ?? this.participated,
        ratio: ratio ?? this.ratio,
        liked: liked ?? this.liked,
      );

  factory PracticeDetailsModel.fromJson(Map<String, dynamic> json) =>
      PracticeDetailsModel(
        id: json["id"],
        level: json["level"],
        body: json["body"],
        breath: json["breath"],
        finished: json["finished"],
        participated: json["participated"],
        ratio: json["ratio"],
        liked: json["liked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "body": body,
        "breath": breath,
        "finished": finished,
        "participated": participated,
        "ratio": ratio,
        "liked": liked,
      };
}
