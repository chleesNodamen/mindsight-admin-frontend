class PracticeEditReqPut {
  String? bodyId;
  String? breathId;

  PracticeEditReqPut({
    this.bodyId,
    this.breathId,
  });

  PracticeEditReqPut copyWith({
    String? bodyId,
    String? breathId,
  }) =>
      PracticeEditReqPut(
        bodyId: bodyId ?? this.bodyId,
        breathId: breathId ?? this.breathId,
      );

  factory PracticeEditReqPut.fromJson(Map<String, dynamic> json) =>
      PracticeEditReqPut(
        bodyId: json["bodyId"],
        breathId: json["breathId"],
      );

  Map<String, dynamic> toJson() => {
        "bodyId": bodyId,
        "breathId": breathId,
      };
}
