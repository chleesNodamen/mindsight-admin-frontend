class DashboardChallengeReqGet {
  int? page;
  String? type;
  List<String>? affiliation;
  bool? chatbot;
  bool? feedback;
  String? search;

  DashboardChallengeReqGet({
    this.page,
    this.type,
    this.affiliation,
    this.chatbot,
    this.feedback,
    this.search,
  });

  DashboardChallengeReqGet copyWith(
          {int? page,
          String? type,
          List<String>? affiliation,
          bool? chatbot,
          bool? feedback,
          String? search}) =>
      DashboardChallengeReqGet(
        page: page ?? this.page,
        type: type ?? this.type,
        affiliation: affiliation ?? this.affiliation,
        chatbot: chatbot ?? this.chatbot,
        feedback: feedback ?? this.feedback,
        search: search ?? this.search,
      );

  factory DashboardChallengeReqGet.fromJson(Map<String, dynamic> json) =>
      DashboardChallengeReqGet(
        page: json["page"],
        type: json["type"],
        affiliation: json["affiliation"] == null
            ? []
            : List<String>.from(json["affiliation"]!.map((x) => x)),
        chatbot: json["chatbot"],
        feedback: json["feedback"],
        search: json["search"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "type": type,
        "affiliation": affiliation == null
            ? []
            : List<dynamic>.from(affiliation!.map((x) => x)),
        "chatbot": chatbot,
        "feedback": feedback,
        "search": search,
      };
}
