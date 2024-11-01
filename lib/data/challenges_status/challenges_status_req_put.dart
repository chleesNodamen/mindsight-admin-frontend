class ChallengesStatusReqPut {
  List<String>? challengeIds;
  bool? status;

  ChallengesStatusReqPut({
    this.challengeIds,
    this.status,
  });

  ChallengesStatusReqPut copyWith({
    List<String>? challengeIds,
    bool? status,
  }) =>
      ChallengesStatusReqPut(
        challengeIds: challengeIds ?? this.challengeIds,
        status: status ?? this.status,
      );

  factory ChallengesStatusReqPut.fromJson(Map<String, dynamic> json) =>
      ChallengesStatusReqPut(
        challengeIds: json["challengeIds"] == null
            ? []
            : List<String>.from(json["ids"]!.map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "challengeIds": challengeIds ?? [],
        "status": status,
      };
}
