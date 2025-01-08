import 'package:mindsight_admin_page/data/base_model.dart';

class ContentDetailsModel extends BaseModel {
  String? id;
  String? category;
  // String? type;
  String? master;
  List<String>? tags;
  String? intro;
  String? thumbnail;
  String? video;
  String? cc;
  String? name;
  int? seen;
  int? liked;
  int? durationTime;
  bool? status;
  bool? exposure;
  String? level;
  String? targetLanguage;

  ContentDetailsModel(
      {this.id,
      this.status,
      this.exposure,
      this.level,
      this.targetLanguage,
      this.category,
      // this.type,
      this.master,
      this.tags,
      this.intro,
      this.thumbnail,
      this.video,
      this.cc,
      this.name,
      this.seen,
      this.liked,
      this.durationTime});

  factory ContentDetailsModel.fromJson(Map<String, dynamic> json) =>
      ContentDetailsModel(
        id: json["id"],
        status: json["status"],
        exposure: json["exposure"],
        level: json["level"],
        targetLanguage: json["targetLanguage"],
        category: json["category"],
        // type: json["type"],
        master: json["master"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"].map((x) => x)),
        intro: json["intro"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        cc: json["cc"],
        name: json["name"],
        seen: json["seen"],
        liked: json["liked"],
        durationTime: json["durationTime"],
      );
}
