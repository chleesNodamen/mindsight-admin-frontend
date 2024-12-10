import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_register/master_register_req_post.dart';

class MasterRegisterRepository extends BaseRepository {
  Future<BaseModel> post(MasterRegisterReqPost dto) async {
    // req
    String endpoint = "master";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
