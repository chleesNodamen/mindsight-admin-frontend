class PracticeExposureReqPut {
  List<String>? ids;
  bool? exposure;

  PracticeExposureReqPut({
    this.ids,
    this.exposure,
  });

  Map<String, dynamic> toJson() => {
        "ids": ids ?? [],
        "exposure": exposure,
      };
}
