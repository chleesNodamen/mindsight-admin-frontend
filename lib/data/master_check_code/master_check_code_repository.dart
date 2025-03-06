import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_check_code/master_check_code_req_post.dart';

class MasterCheckCodeRepository extends BaseRepository {
  Future<BaseModel> post(MasterCheckCodeReqPost dto) async {
    String endpoint = "master/check-code";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
