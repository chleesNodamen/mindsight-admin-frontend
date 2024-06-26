class DashboardChallengeReqGet {
  int? page;

  DashboardChallengeReqGet({
    this.page,
  });

  DashboardChallengeReqGet copyWith({int? page}) =>
      DashboardChallengeReqGet(page: page ?? this.page);

  factory DashboardChallengeReqGet.fromJson(Map<String, dynamic> json) =>
      DashboardChallengeReqGet(page: json["page"]);

  Map<String, dynamic> toJson() => {"page": page}
      .map((key, value) => MapEntry(key, value.toString()));
}
