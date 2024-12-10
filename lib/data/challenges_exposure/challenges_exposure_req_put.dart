class ChallengesExposureReqPut {
  List<String>? challengeIds;
  bool? exposure;

  ChallengesExposureReqPut({
    this.challengeIds,
    this.exposure,
  });

  Map<String, dynamic> toJson() => {
        "challengeIds": challengeIds ?? [],
        "exposure": exposure,
      };
}
