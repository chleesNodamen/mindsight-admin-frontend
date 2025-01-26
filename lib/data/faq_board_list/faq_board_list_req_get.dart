// lib/data/company_manage/company_req_get.dart

class FAQBoardListReqGet {
  int? page;
  String? search;

  FAQBoardListReqGet({
    this.page,
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "search": search,
      };
}
