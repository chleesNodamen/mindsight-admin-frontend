import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenge_edit/challenge_edit_req_put.dart';

class ChallengeEditRepository extends BaseRepository {
  Future<BaseModel> put(String? id, ChallengeEditReqPut dto) async {
    // req
    String endpoint = "contents/challenge-edit/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
