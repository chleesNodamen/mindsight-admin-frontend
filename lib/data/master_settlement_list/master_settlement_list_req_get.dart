class MasterSettlementListReqGet {
  int? page;
  int? month;
  String? search;

  MasterSettlementListReqGet({
    this.page,
    this.month,
    this.search,
  });

  MasterSettlementListReqGet copyWith({
    int? page,
    int? month,
    String? search,
  }) =>
      MasterSettlementListReqGet(
        page: page ?? this.page,
        month: month ?? this.month,
        search: search ?? this.search,
      );

  factory MasterSettlementListReqGet.fromJson(Map<String, dynamic> json) =>
      MasterSettlementListReqGet(
        page: json["page"],
        month: json["month"],
        search: json["search"],
      );

  Map<String, dynamic> toJson() => {
        "page": page.toString(),
        "month": month.toString(),
        "search": search,
      };
}
