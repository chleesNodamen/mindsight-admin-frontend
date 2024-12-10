import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenges_status/challenges_status_req_put.dart';

class ChallengesStatusRepository extends BaseRepository {
  Future<BaseModel> put(ChallengesStatusReqPut dto) async {
    // req
    String endpoint = "contents/challenge-status";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
