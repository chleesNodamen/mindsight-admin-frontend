class MasterListReqGet {
  int? page;
  String? search;
  String? masterId;
  bool? verified;

  MasterListReqGet({
    this.page,
    this.search,
    this.masterId,
    this.verified,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "verified": verified,
        "search": search,
        "masterId": masterId,
      };
}
