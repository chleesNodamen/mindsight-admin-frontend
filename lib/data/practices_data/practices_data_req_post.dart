class PracticesDataReqPost {
  String? bodyId;
  String? breathId;

  PracticesDataReqPost({
    this.bodyId,
    this.breathId,
  });

  PracticesDataReqPost copyWith({
    String? bodyId,
    String? breathId,
  }) =>
      PracticesDataReqPost(
        bodyId: bodyId ?? this.bodyId,
        breathId: breathId ?? this.breathId,
      );

  factory PracticesDataReqPost.fromJson(Map<String, dynamic> json) =>
      PracticesDataReqPost(
        bodyId: json["bodyId"],
        breathId: json["breathId"],
      );

  Map<String, dynamic> toJson() => {
        "bodyId": bodyId,
        "breathId": breathId,
      };
}
