class ContentRegisterReqPost {
  String? name;
  String? category;
  String? type;
  String? level;
  String? targetLanguage;
  bool? exposure;
  List<String>? tags;
  String? intro;
  String? media;
  String? thumbnail;

  ContentRegisterReqPost({
    this.name,
    this.category,
    this.type,
    this.level,
    this.targetLanguage,
    this.exposure,
    this.tags,
    this.intro,
    this.media,
    this.thumbnail,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "category": category,
        "type": type,
        "level": level,
        "targetLanguage": targetLanguage,
        "exposure": exposure,
        "tags": tags ?? [],
        "intro": intro,
        "media": media,
        "thumbnail": thumbnail,
      };
}
