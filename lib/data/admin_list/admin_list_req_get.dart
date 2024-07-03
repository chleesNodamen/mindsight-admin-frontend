class AdminListReqGet {
  int? page;

  AdminListReqGet({
    this.page,
  });

  AdminListReqGet copyWith({
    int? page,
  }) =>
      AdminListReqGet(
        page: page ?? this.page,
      );

  factory AdminListReqGet.fromJson(Map<String, dynamic> json) =>
      AdminListReqGet(
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
      }.map((key, value) => MapEntry(key, value.toString()));
}
