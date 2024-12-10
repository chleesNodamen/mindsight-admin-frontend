class PracticeListReqGet {
  int? page;
  String? sortBy;
  String? search;
  String? masterId;

  PracticeListReqGet({
    this.page,
    this.sortBy,
    this.search,
    this.masterId,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "sortBy": sortBy,
        "search": search,
        "masterId": masterId,
      };
}
