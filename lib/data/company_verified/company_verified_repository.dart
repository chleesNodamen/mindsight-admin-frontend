import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/company_verified/company_verified_req_put.dart';

class CompanyVerifiedRepository extends BaseRepository {
  Future<BaseModel> put(CompanyVerifiedReqPut dto) async {
    // req
    String endpoint = "company/verified";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
