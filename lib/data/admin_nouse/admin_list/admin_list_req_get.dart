class AdminListReqGet {
  int? page;

  AdminListReqGet({
    this.page,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
      };
}
