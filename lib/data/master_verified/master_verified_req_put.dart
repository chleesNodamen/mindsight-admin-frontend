class MasterVerifiedReqPut {
  List<String>? ids;
  bool? verified;

  MasterVerifiedReqPut({
    this.ids,
    this.verified,
  });

  MasterVerifiedReqPut copyWith({
    List<String>? ids,
    bool? verified,
  }) =>
      MasterVerifiedReqPut(
        ids: ids ?? this.ids,
        verified: verified ?? this.verified,
      );

  factory MasterVerifiedReqPut.fromJson(Map<String, dynamic> json) =>
      MasterVerifiedReqPut(
        ids: json["ids"] == null
            ? []
            : List<String>.from(json["ids"]!.map((x) => x)),
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "ids": ids ?? [],
        "verified": verified,
      };
}
