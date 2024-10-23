class SettlementSummaryReqGet {
  int? month;
  String? search;

  SettlementSummaryReqGet({
    this.month,
    this.search,
  });

  SettlementSummaryReqGet copyWith({
    int? month,
    String? search,
  }) =>
      SettlementSummaryReqGet(
        month: month ?? this.month,
        search: search ?? this.search,
      );

  factory SettlementSummaryReqGet.fromJson(Map<String, dynamic> json) =>
      SettlementSummaryReqGet(
        month: json["month"],
        search: json["search"],
      );

  Map<String, dynamic> toJson() => {
        "month": month.toString(),
        "search": search,
      };
}
