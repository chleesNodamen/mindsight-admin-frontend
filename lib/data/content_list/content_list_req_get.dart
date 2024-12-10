class ContentListReqGet {
  int? page;
  String? sortBy;
  List<String>? type;
  bool? status;
  String? search;
  int? pageSize;
  String? masterId;

  ContentListReqGet({
    this.page,
    this.sortBy,
    this.type,
    this.status,
    this.search,
    this.pageSize,
    this.masterId,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "sortBy": sortBy,
        "type": type ?? [],
        "status": status,
        "search": search,
        "pageSize": pageSize,
        "masterId": masterId,
      };
}
