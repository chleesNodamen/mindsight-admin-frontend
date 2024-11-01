class ChallengesReqGet {
  int? page;
  String? sortBy;
  List<String>? goal;
  List<int>? days;
  bool? status;
  String? search;

  ChallengesReqGet({
    this.page,
    this.sortBy,
    this.goal,
    this.days,
    this.status,
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "sortBy": sortBy,
        "goal": goal ?? [],
        "days": days ?? [],
        "search": search,
        "status": status,
      };
}
