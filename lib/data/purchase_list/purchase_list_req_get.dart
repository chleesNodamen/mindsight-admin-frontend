class PurchaseListReqGet {
  int? page;
  int? month;
  String? search;

  PurchaseListReqGet({
    this.page,
    this.month,
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "page": page.toString(),
        "month": month.toString(),
        "search": search,
      };
}
