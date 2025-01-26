// lib/data/company_manage/company_req_get.dart

class FreeBoardCommentListReqGet {
  int? page;
  String? search;

  FreeBoardCommentListReqGet({
    this.page,
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "search": search,
      };
}
