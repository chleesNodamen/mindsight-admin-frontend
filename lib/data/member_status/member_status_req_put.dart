class MemberStatusReqPut {
  List<String>? ids;
  bool? status;

  MemberStatusReqPut({
    this.ids,
    this.status,
  });

  MemberStatusReqPut copyWith({
    List<String>? ids,
    bool? status,
  }) =>
      MemberStatusReqPut(
        ids: ids ?? this.ids,
        status: status ?? this.status,
      );

  factory MemberStatusReqPut.fromJson(Map<String, dynamic> json) =>
      MemberStatusReqPut(
        ids: json["ids"] == null
            ? []
            : List<String>.from(json["ids"]!.map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "ids": ids ?? [],
        "status": status,
      };
}
