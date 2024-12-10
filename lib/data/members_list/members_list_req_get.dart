class MembersListReqGet {
  int? page;
  List<String>? affiliation;
  String? search;
  bool? disabled;

  MembersListReqGet({
    this.page,
    this.affiliation,
    this.search,
    this.disabled,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "page": page,
      "affiliation": affiliation ?? [],
      "disabled": disabled,
    };
    if (search != null) {
      data["search"] = search;
    }
    return data;
  }
}
