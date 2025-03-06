class AdminDeleteReqDelete {
  List<String>? ids;

  AdminDeleteReqDelete({
    this.ids,
  });

  AdminDeleteReqDelete copyWith({
    List<String>? ids,
  }) =>
      AdminDeleteReqDelete(
        ids: ids ?? this.ids,
      );

  factory AdminDeleteReqDelete.fromJson(Map<String, dynamic> json) =>
      AdminDeleteReqDelete(
        ids: json["ids"] == null
            ? []
            : List<String>.from(json["ids"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ids": ids ?? [],
      };
}
