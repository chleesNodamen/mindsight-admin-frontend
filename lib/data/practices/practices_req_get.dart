class PracticesReqGet {
  int? page;
  String? sortBy;
  String? search;

  PracticesReqGet({
    this.page,
    this.sortBy,
    this.search,
  });

  PracticesReqGet copyWith({
    int? page,
    String? sortBy,
    String? search,
  }) =>
      PracticesReqGet(
        page: page ?? this.page,
        sortBy: sortBy ?? this.sortBy,
        search: search ?? this.search,
      );

  factory PracticesReqGet.fromJson(Map<String, dynamic> json) =>
      PracticesReqGet(
        page: json["page"],
        sortBy: json["sortBy"],
        search: json["search"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "sortBy": sortBy,
        "search": search,
      };
}
