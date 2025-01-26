class ContentEditReqPut {
  String? category;
  // String? type;
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

  ContentEditReqPut({
    this.category,
    // this.type,
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
  });

  Map<String, dynamic> toJson() => {
        "category": category,
        // "type": type,
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
      };
}
