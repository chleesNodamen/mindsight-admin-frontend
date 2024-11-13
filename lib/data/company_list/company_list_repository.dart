// lib/data/company_manage/company_repository.dart

import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/company_list/company_list_model.dart';
import 'package:mindsight_admin_page/data/company_list/company_list_req_get.dart';

class CompanyListRepository extends BaseRepository {
  Future<CompanyListModel> get(CompanyListReqGet dto) async {
    // req
    String endpoint = "companies";
    http.Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    CompanyListModel model =
        fetchJsonData<CompanyListModel>(response, CompanyListModel.fromJson);

    return model;
  }
}
