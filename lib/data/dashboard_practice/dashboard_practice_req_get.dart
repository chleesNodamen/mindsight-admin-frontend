class DashboardPracticeReqGet {
  int? page;

  DashboardPracticeReqGet({
    this.page,
  });

  DashboardPracticeReqGet copyWith({int? page}) => DashboardPracticeReqGet(
        page: page ?? this.page,
      );

  factory DashboardPracticeReqGet.fromJson(Map<String, dynamic> json) =>
      DashboardPracticeReqGet(
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
      };
}
