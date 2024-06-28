class ActivityExpertReqPut {
  String? type;
  String? feedback;

  ActivityExpertReqPut({
    this.type,
    this.feedback,
  });

  ActivityExpertReqPut copyWith({
    String? type,
    String? feedback,
  }) =>
      ActivityExpertReqPut(
        type: type ?? this.type,
        feedback: feedback ?? this.feedback,
      );

  factory ActivityExpertReqPut.fromJson(Map<String, dynamic> json) =>
      ActivityExpertReqPut(
        type: json["type"],
        feedback: json["feedback"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "feedback": feedback,
      };
}
