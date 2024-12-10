class ChallengesListReqGet {
  int? page;
  String? sortBy;
  List<String>? goal;
  List<int>? days;
  bool? status;
  String? search;
  String? masterId;

  ChallengesListReqGet({
    this.page,
    this.sortBy,
    this.goal,
    this.days,
    this.status,
    this.search,
    this.masterId,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "sortBy": sortBy,
        "goal": goal ?? [],
        "days": days ?? [],
        "search": search,
        "status": status,
        "masterId": masterId,
      };
}
