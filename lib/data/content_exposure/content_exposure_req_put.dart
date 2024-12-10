class ContentExposureReqPut {
  List<String>? contentIds;
  bool? exposure;

  ContentExposureReqPut({
    this.contentIds,
    this.exposure,
  });

  Map<String, dynamic> toJson() => {
        "contentIds": contentIds ?? [],
        "exposure": exposure,
      };
}
