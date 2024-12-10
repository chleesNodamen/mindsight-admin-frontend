class PracticeEditReqPut {
  String? bodyId;
  String? breathId;
  bool? status;
  bool? exposure;

  PracticeEditReqPut({
    this.bodyId,
    this.breathId,
    this.status,
    this.exposure,
  });

  Map<String, dynamic> toJson() => {
        "bodyId": bodyId,
        "breathId": breathId,
        "status": status,
        "exposure": exposure,
      };
}
