class ContentRegisterReqPost {
  String? name;
  String? category;
  String? level;
  String? targetLanguage;
  bool? exposure;
  List<String>? tags;
  String? intro;
  String? media;
  String? thumbnail;
  int? durationTime;
  // List<double>? embedding; // 임베딩 값을 위한 새 필드

  ContentRegisterReqPost({
    this.name,
    this.category,
    this.level,
    this.targetLanguage,
    this.exposure,
    this.tags,
    this.intro,
    this.media,
    this.thumbnail,
    this.durationTime,
    // this.embedding,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "category": category,
        "level": level,
        "targetLanguage": targetLanguage,
        "exposure": exposure,
        "tags": tags ?? [],
        "intro": intro,
        "media": media,
        "thumbnail": thumbnail,
        "durationTime": durationTime,
        // "embedding": embedding, // 임베딩 값 추가
      };
}
