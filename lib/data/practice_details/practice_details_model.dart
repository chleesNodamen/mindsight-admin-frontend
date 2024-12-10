import 'package:mindsight_admin_page/data/base_model.dart';

class PracticeDetailsModel extends BaseModel {
  String? id;
  int? level;
  String? body;
  String? breath;
  int? finished;
  int? participated;
  String? ratio;
  String? masterNickname;
  int? liked;
  bool? status;
  bool? exposure;

  PracticeDetailsModel(
      {this.id,
      this.level,
      this.body,
      this.breath,
      this.finished,
      this.participated,
      this.ratio,
      this.masterNickname,
      this.status,
      this.exposure,
      this.liked});

  factory PracticeDetailsModel.fromJson(Map<String, dynamic> json) =>
      PracticeDetailsModel(
        id: json["id"],
        level: json["level"],
        body: json["body"],
        breath: json["breath"],
        finished: json["finished"],
        participated: json["participated"],
        ratio: json["ratio"],
        masterNickname: json["masterNickname"],
        liked: json["liked"],
        status: json["status"],
        exposure: json["exposure"],
      );
}
