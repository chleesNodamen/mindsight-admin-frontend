class MasterSettlementListReqGet {
  int? page;
  String? search;

  MasterSettlementListReqGet({
    this.page,
    this.search,
  });

  MasterSettlementListReqGet copyWith({
    int? page,
    String? search,
  }) =>
      MasterSettlementListReqGet(
        page: page ?? this.page,
        search: search ?? this.search,
      );

  factory MasterSettlementListReqGet.fromJson(Map<String, dynamic> json) =>
      MasterSettlementListReqGet(
        page: json["page"],
        search: json["search"],
      );

  Map<String, dynamic> toJson() => {
        "page": page.toString(),
        "search": search,
      };
}
