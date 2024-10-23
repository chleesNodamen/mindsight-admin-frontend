class ActivityReqGet {
  int? page;
  String? type;
  List<String>? affiliation;
  bool? chatbot;
  bool? feedback;
  String? search;

  ActivityReqGet({
    this.page,
    this.type,
    this.affiliation,
    this.chatbot,
    this.feedback,
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "type": type,
        "affiliation": affiliation ?? [],
        "chatbot": chatbot,
        "feedback": feedback,
        "search": search,
      };
}
