class MembersStatusReqPut {
  List<String>? ids;
  bool? status;

  MembersStatusReqPut({
    this.ids,
    this.status,
  });

  MembersStatusReqPut copyWith({
    List<String>? ids,
    bool? status,
  }) =>
      MembersStatusReqPut(
        ids: ids ?? this.ids,
        status: status ?? this.status,
      );

  factory MembersStatusReqPut.fromJson(Map<String, dynamic> json) =>
      MembersStatusReqPut(
        ids: json["ids"] == null
            ? []
            : List<String>.from(json["ids"]!.map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "ids": ids == null ? [] : List<dynamic>.from(ids!.map((x) => x)),
        "status": status,
      };
}
