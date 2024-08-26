class ContentListReqGet {
  int? page;
  String? sortBy;
  List<String>? type;
  bool? status;
  String? search;
  int? pageSize;

  ContentListReqGet({
    this.page,
    this.sortBy,
    this.type,
    this.status,
    this.search,
    this.pageSize,
  });

  ContentListReqGet copyWith({
    int? page,
    String? sortBy,
    List<String>? type,
    bool? status,
    String? search,
    int? pageSize,
  }) =>
      ContentListReqGet(
        page: page ?? this.page,
        sortBy: sortBy ?? this.sortBy,
        type: type ?? this.type,
        status: status ?? this.status,
        search: search ?? this.search,
        pageSize: pageSize ?? this.pageSize,
      );

  factory ContentListReqGet.fromJson(Map<String, dynamic> json) =>
      ContentListReqGet(
        page: json["page"],
        sortBy: json["sortBy"],
        type: json["type"] == null
            ? []
            : List<String>.from(json["type"]!.map((x) => x)),
        status: json["status"],
        search: json["search"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "page": page.toString(),
        "sortBy": sortBy,
        "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
        "status": status,
        "search": search,
        "pageSize": pageSize,
      };
}
