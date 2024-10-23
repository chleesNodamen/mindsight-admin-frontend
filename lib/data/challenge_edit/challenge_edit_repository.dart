import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenge_edit/challenge_edit_model.dart';
import 'package:mindsight_admin_page/data/challenge_edit/challenge_edit_req_put.dart';

class ChallengeEditRepository extends BaseRepository {
  Future<ChallengeEditModel> put(String? id, ChallengeEditReqPut dto) async {
    // req
    String endpoint = "contents/challenges/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    ChallengeEditModel model = fetchJsonData<ChallengeEditModel>(
        response, ChallengeEditModel.fromJson);

    return model;
  }
}
