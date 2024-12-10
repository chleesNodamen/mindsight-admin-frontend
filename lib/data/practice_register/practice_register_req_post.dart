class PracticesRegisterReqPost {
  String? bodyId;
  String? breathId;

  PracticesRegisterReqPost({
    this.bodyId,
    this.breathId,
  });

  PracticesRegisterReqPost copyWith({
    String? bodyId,
    String? breathId,
  }) =>
      PracticesRegisterReqPost(
        bodyId: bodyId ?? this.bodyId,
        breathId: breathId ?? this.breathId,
      );

  factory PracticesRegisterReqPost.fromJson(Map<String, dynamic> json) =>
      PracticesRegisterReqPost(
        bodyId: json["bodyId"],
        breathId: json["breathId"],
      );

  Map<String, dynamic> toJson() => {
        "bodyId": bodyId,
        "breathId": breathId,
      };
}
