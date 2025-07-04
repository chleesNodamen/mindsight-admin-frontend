class ContentEditReqPut {
  String? category;
  List<String>? tags;
  String? intro;
  String? thumbnail;
  String? video;
  String? cc;
  String? name;
  String? level;
  String? targetLanguage;
  bool? status;
  bool? exposure;
  int? durationTime;
  String? masterId;

  ContentEditReqPut({
    this.category,
    this.tags,
    this.intro,
    this.thumbnail,
    this.video,
    this.cc,
    this.name,
    this.level,
    this.targetLanguage,
    this.status,
    this.exposure,
    this.durationTime,
    this.masterId,
  });

  Map<String, dynamic> toJson() => {
        "category": category,
        "tags": tags ?? [],
        "intro": intro,
        "thumbnail": thumbnail,
        "video": video,
        "cc": cc,
        "name": name,
        "level": level,
        "targetLanguage": targetLanguage,
        "status": status,
        "exposure": exposure,
        "durationTime": durationTime,
        "masterId": masterId,
      };
}
