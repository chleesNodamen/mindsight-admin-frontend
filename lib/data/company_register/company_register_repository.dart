// lib/data/company_register/company_register_repository.dart

import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/company_register/company_register_req_post.dart';

class CompanyRegisterRepository extends BaseRepository {
  Future<BaseModel> post(CompanyRegisterReqPost dto) async {
    // req
    String endpoint = "company";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
