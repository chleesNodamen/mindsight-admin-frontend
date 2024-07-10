class ContentListReqGet {
  int? page;
  List<String>? type;
  bool? status;
  String? search;

  ContentListReqGet({
    this.page,
    this.type,
    this.status,
    this.search,
  });

  ContentListReqGet copyWith({
    int? page,
    List<String>? type,
    bool? status,
    String? search,
  }) =>
      ContentListReqGet(
        page: page ?? this.page,
        type: type ?? this.type,
        status: status ?? this.status,
        search: search ?? this.search,
      );

  factory ContentListReqGet.fromJson(Map<String, dynamic> json) =>
      ContentListReqGet(
        page: json["page"],
        type: json["type"] == null
            ? []
            : List<String>.from(json["type"]!.map((x) => x)),
        status: json["status"],
        search: json["search"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
        "status": status,
        "search": search,
      };
}
