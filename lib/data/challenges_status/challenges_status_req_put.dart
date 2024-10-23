class ChallengesStatusReqPut {
  List<String>? challengesId;
  bool? status;

  ChallengesStatusReqPut({
    this.challengesId,
    this.status,
  });

  ChallengesStatusReqPut copyWith({
    List<String>? challengesId,
    bool? status,
  }) =>
      ChallengesStatusReqPut(
        challengesId: challengesId ?? this.challengesId,
        status: status ?? this.status,
      );

  factory ChallengesStatusReqPut.fromJson(Map<String, dynamic> json) =>
      ChallengesStatusReqPut(
        challengesId: json["challengesId"] == null
            ? []
            : List<String>.from(json["ids"]!.map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "challengesId": challengesId ?? [],
        "status": status,
      };
}
