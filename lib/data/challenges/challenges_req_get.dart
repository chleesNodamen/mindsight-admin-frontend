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

  ChallengesReqGet copyWith({
    int? page,
    String? sortBy,
    List<String>? goal,
    List<int>? duration,
    bool? status,
    String? search,
  }) =>
      ChallengesReqGet(
        page: page ?? this.page,
        sortBy: sortBy ?? this.sortBy,
        goal: goal ?? this.goal,
        duration: duration ?? this.duration,
        status: status ?? this.status,
        search: search ?? this.search,
      );

  factory ChallengesReqGet.fromJson(Map<String, dynamic> json) =>
      ChallengesReqGet(
        page: json["page"],
        sortBy: json["sortBy"],
        goal: json["goal"] == null
            ? []
            : List<String>.from(json["goal"]!.map((x) => x)),
        duration: json["duration"] == null
            ? []
            : List<int>.from(json["duration"]!.map((x) => x)),
        status: json["status"],
        search: json["search"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "sortBy": sortBy,
        "goal": goal == null ? [] : List<dynamic>.from(goal!.map((x) => x)),
        "duration":
            duration == null ? [] : List<dynamic>.from(duration!.map((x) => x)),
        "search": search,
      }.map((key, value) => MapEntry(key, value.toString()));
}
