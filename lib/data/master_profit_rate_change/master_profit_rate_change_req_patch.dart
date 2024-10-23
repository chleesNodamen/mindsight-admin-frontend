class MasterProfitRateChangeReqPatch {
  String? masterId;
  double? rate;

  MasterProfitRateChangeReqPatch({
    this.masterId,
    this.rate,
  });

  MasterProfitRateChangeReqPatch copyWith({
    String? masterId,
    double? rate,
  }) =>
      MasterProfitRateChangeReqPatch(
        masterId: masterId ?? this.masterId,
        rate: rate ?? this.rate,
      );

  factory MasterProfitRateChangeReqPatch.fromJson(Map<String, dynamic> json) =>
      MasterProfitRateChangeReqPatch(
        masterId: json["masterId"],
        rate: json["rate"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "masterId": masterId,
        "rate": rate,
      };
}
