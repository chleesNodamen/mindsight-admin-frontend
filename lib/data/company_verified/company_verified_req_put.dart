class CompanyVerifiedReqPut {
  List<String>? ids;
  bool? verified;

  CompanyVerifiedReqPut({
    this.ids,
    this.verified,
  });

  CompanyVerifiedReqPut copyWith({
    List<String>? ids,
    bool? verified,
  }) =>
      CompanyVerifiedReqPut(
        ids: ids ?? this.ids,
        verified: verified ?? this.verified,
      );

  factory CompanyVerifiedReqPut.fromJson(Map<String, dynamic> json) =>
      CompanyVerifiedReqPut(
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
