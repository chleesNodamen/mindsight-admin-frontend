// lib/data/company_manage/company_req_get.dart

class CompanyListReqGet {
  int? page;
  String? search;
  bool? verified;

  CompanyListReqGet({
    this.page,
    this.search,
    this.verified,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "page": page ?? 1,
      "verified": verified ?? false,
    };
    if (search != null && search!.isNotEmpty) {
      data["search"] = search;
    }
    return data;
  }
}
