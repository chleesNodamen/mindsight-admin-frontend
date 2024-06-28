class MembersReqGet {
  int? page;
  List<String>? affiliation;
  String? search;
  bool? disabled;

  MembersReqGet({
    this.page,
    this.affiliation,
    this.search,
    this.disabled,
  });

  MembersReqGet copyWith({int? page, List<String>? affiliation, String? search, bool? disabled}) =>
      MembersReqGet(
        page: page ?? this.page,
        affiliation: affiliation ?? this.affiliation,
        search: search ?? this.search,
        disabled: disabled ?? this.disabled,
        );

  factory MembersReqGet.fromJson(Map<String, dynamic> json) =>
      MembersReqGet(
        page: json["page"],
        affiliation: json["affiliation"] == null
            ? []
            : List<String>.from(json["affiliation"]!.map((x) => x)),
        search: json["search"],
        disabled: json["disabled"],);

  Map<String, dynamic> toJson() => {
    "page": page,
    "affiliation": affiliation == null ? [] : List<dynamic>.from(affiliation!.map((x) => x)),
    "search": search,
    "disabled": disabled,
    };
}
