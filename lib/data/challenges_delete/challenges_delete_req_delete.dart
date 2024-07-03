class ChallengesDeleteReqDelete {
  String? challengeIds;

  ChallengesDeleteReqDelete({
    this.challengeIds,
  });

  ChallengesDeleteReqDelete copyWith({
    String? challengeIds,
  }) =>
      ChallengesDeleteReqDelete(
        challengeIds: challengeIds ?? this.challengeIds,
      );

  factory ChallengesDeleteReqDelete.fromJson(Map<String, dynamic> json) =>
      ChallengesDeleteReqDelete(
        challengeIds: json["challengeIds"],
      );

  Map<String, dynamic> toJson() => {
        "challengeIds": challengeIds,
      };
}
