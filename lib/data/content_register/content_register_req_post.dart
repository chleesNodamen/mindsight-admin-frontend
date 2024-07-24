class ContentRegisterReqPost {
  String? category;
  String? type;
  String? master;
  List<String>? tags;
  String? intro;
  String? thumbnail;
  String? video;
  String? cc;
  String? name;

  ContentRegisterReqPost({
    this.category,
    this.type,
    this.master,
    this.tags,
    this.intro,
    this.thumbnail,
    this.video,
    this.cc,
    this.name,
  });

  ContentRegisterReqPost copyWith({
    String? category,
    String? type,
    String? master,
    List<String>? tags,
    String? intro,
    String? thumbnail,
    String? video,
    String? cc,
    String? name,
  }) =>
      ContentRegisterReqPost(
        category: category ?? this.category,
        type: type ?? this.type,
        master: master ?? this.master,
        tags: tags ?? this.tags,
        intro: intro ?? this.intro,
        thumbnail: thumbnail ?? this.thumbnail,
        video: video ?? this.video,
        cc: cc ?? this.cc,
        name: name ?? this.name,
      );

  factory ContentRegisterReqPost.fromJson(Map<String, dynamic> json) =>
      ContentRegisterReqPost(
        category: json["category"],
        type: json["type"],
        master: json["master"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        intro: json["intro"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        cc: json["cc"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "type": type,
        "master": master,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "intro": intro,
        "thumbnail": thumbnail,
        "video": video,
        "cc": cc,
        "name": name,
      };
}
