class MasterListReqGet {
  int? page;
  int? pageSize;
  String? search;
  String? masterId;
  bool? verified;

  MasterListReqGet({
    this.page,
    this.pageSize = 20,
    this.search,
    this.masterId,
    this.verified,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "verified": verified,
        "search": search,
        "masterId": masterId,
      };
}
