import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenges/challenges_model.dart';
import 'package:mindsight_admin_page/data/challenges/challenges_req_get.dart';

class ChallengesRepository extends BaseRepository {
  Future<ChallengesModel> get(ChallengesReqGet dto) async {
    // req
    String endpoint = "contents/challenges";
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    ChallengesModel model =
        fetchJsonData<ChallengesModel>(response, ChallengesModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
