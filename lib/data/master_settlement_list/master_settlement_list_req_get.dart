class MasterSettlementListReqGet {
  int? page;
  int? month;
  String? search;
  String? masterId;

  MasterSettlementListReqGet({
    this.page,
    this.month,
    this.search,
    this.masterId,
  });

  Map<String, dynamic> toJson() => {
        "page": page.toString(),
        "month": month.toString(),
        "search": search,
        "masterId": masterId,
      };
}
