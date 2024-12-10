import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenge_register/challenge_register_req_put.dart';

class ChallengeRegisterRepository extends BaseRepository {
  Future<BaseModel> post(ChallengeRegisterReqPost dto) async {
    // req
    String endpoint = "contents/challenge-register";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
