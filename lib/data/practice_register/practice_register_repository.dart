import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/practice_register/practice_register_req_post.dart';

class PracticesRegisterRepository extends BaseRepository {
  Future<BaseModel> post(PracticesRegisterReqPost dto) async {
    // req
    String endpoint = "contents/practice-register";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
