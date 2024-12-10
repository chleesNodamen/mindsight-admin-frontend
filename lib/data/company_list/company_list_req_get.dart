// lib/data/company_manage/company_req_get.dart

class CompanyListReqGet {
  int? page;
  String? search;
  String? masterId;
  bool? verified;

  CompanyListReqGet({
    this.page,
    this.search,
    this.masterId,
    this.verified,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "search": search,
        "masterId": masterId,
        "verified": verified,
      };
}
