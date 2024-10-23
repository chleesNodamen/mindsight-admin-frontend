class MasterProfitRateListReqGet {
  int? page;
  String? search;

  MasterProfitRateListReqGet({
    this.page,
    this.search,
  });

  MasterProfitRateListReqGet copyWith({
    int? page,
    String? search,
  }) =>
      MasterProfitRateListReqGet(
        page: page ?? this.page,
        search: search ?? this.search,
      );

  factory MasterProfitRateListReqGet.fromJson(Map<String, dynamic> json) =>
      MasterProfitRateListReqGet(
        page: json["page"],
        search: json["search"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "search": search,
      };
}
