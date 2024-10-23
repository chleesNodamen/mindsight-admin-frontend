class MasterContentSettlementListReqGet {
  String? masterId;
  int? page;
  int? month;

  MasterContentSettlementListReqGet({
    this.masterId,
    this.page,
    this.month,
  });

  MasterContentSettlementListReqGet copyWith({
    String? masterId,
    int? page,
    int? month,
  }) =>
      MasterContentSettlementListReqGet(
        masterId: masterId ?? this.masterId,
        page: page ?? this.page,
        month: month ?? this.month,
      );

  factory MasterContentSettlementListReqGet.fromJson(
          Map<String, dynamic> json) =>
      MasterContentSettlementListReqGet(
        masterId: json["masterId"],
        page: json["page"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "masterId": masterId,
        "page": page.toString(),
        "month": month.toString(),
      };
}
