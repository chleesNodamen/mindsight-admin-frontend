// lib/data/company_manage/company_req_get.dart

class FreeBoardListReqGet {
  int? page;
  String? search;

  FreeBoardListReqGet({
    this.page,
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "search": search,
      };
}
