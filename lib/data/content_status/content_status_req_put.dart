class ContentStatusReqPut {
  List<String>? contentIds;
  bool? status;

  ContentStatusReqPut({
    this.contentIds,
    this.status,
  });

  ContentStatusReqPut copyWith({
    List<String>? contentIds,
    bool? status,
  }) =>
      ContentStatusReqPut(
        contentIds: contentIds ?? this.contentIds,
        status: status ?? this.status,
      );

  factory ContentStatusReqPut.fromJson(Map<String, dynamic> json) =>
      ContentStatusReqPut(
        contentIds: json["contentIds"] == null
            ? []
            : List<String>.from(json["ids"]!.map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "contentIds": contentIds == null
            ? []
            : List<dynamic>.from(contentIds!.map((x) => x)),
        "status": status,
      };
}
