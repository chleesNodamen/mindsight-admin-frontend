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

  Map<String, dynamic> toJson() => {
        "page": page,
        "sortBy": sortBy,
        "type": type ?? [],
        "status": status,
        "search": search,
        "pageSize": pageSize,
      };
}
