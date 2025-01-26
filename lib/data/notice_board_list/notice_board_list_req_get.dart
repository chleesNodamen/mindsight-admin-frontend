// lib/data/company_manage/company_req_get.dart

class NoticeBoardListReqGet {
  int? page;
  String? search;

  NoticeBoardListReqGet({
    this.page,
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "search": search,
      };
}
