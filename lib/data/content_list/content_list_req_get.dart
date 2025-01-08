class ContentListReqGet {
  int? page;
  String? sortBy;
  List<String>? category;
  bool? status;
  String? search;
  int? pageSize;
  String? masterId;

  ContentListReqGet({
    this.page,
    this.sortBy,
    this.category,
    this.status,
    this.search,
    this.pageSize,
    this.masterId,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "sortBy": sortBy,
        "category": category ?? [],
        "status": status,
        "search": search,
        "pageSize": pageSize,
        "masterId": masterId,
      };
}
