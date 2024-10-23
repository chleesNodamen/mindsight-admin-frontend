class ChallengesReqGet {
  int? page;
  String? sortBy;
  List<String>? goal;
  List<int>? duration;
  bool? status;
  String? search;

  ChallengesReqGet({
    this.page,
    this.sortBy,
    this.goal,
    this.duration,
    this.status,
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "sortBy": sortBy,
        "goal": goal ?? [],
        "duration": duration ?? [],
        "search": search,
        "status": status,
      };
}
