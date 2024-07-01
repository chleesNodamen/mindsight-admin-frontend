import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/data/base_model.dart';

class ContentDetailsModel extends BaseModel {
  String? id;
  String? category;
  String? type;
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

  ContentDetailsModel(
      {this.id,
      this.category,
      this.type,
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

  ContentDetailsModel copyWith(
          {String? id,
          String? category,
          String? type,
          String? master,
          List<String>? tags,
          String? intro,
          String? thumbnail,
          String? video,
          String? cc,
          String? name,
          int? seen,
          int? liked,
          int? durationTime}) =>
      ContentDetailsModel(
        id: id ?? this.id,
        category: category ?? this.category,
        type: type ?? this.type,
        master: master ?? this.master,
        tags: tags ?? this.tags,
        intro: intro ?? this.intro,
        thumbnail: thumbnail ?? this.thumbnail,
        video: video ?? this.video,
        cc: cc ?? this.cc,
        name: name ?? this.name,
        seen: seen ?? this.seen,
        liked: liked ?? this.liked,
        durationTime: durationTime ?? this.durationTime,
      );

  factory ContentDetailsModel.fromJson(Map<String, dynamic> json) =>
      ContentDetailsModel(
        id: json["id"],
        category: json["category"],
        type: json["type"],
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "type": type,
        "master": master,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "intro": intro,
        "thumbnail": thumbnail,
        "video": video,
        "cc": cc,
        "name": name,
        "seen": seen,
        "liked": liked,
        "durationTime": durationTime,
      };
}
