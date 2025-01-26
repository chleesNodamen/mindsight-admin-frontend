// lib/data/company_manage/company_req_get.dart

class InquiryBoardListReqGet {
  int? page;
  String? search;
  String? masterId;

  InquiryBoardListReqGet({
    this.page,
    this.search,
    this.masterId,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "search": search,
        "masterId": masterId,
      };
}
