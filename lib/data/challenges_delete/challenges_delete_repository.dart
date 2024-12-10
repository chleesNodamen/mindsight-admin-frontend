import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenges_delete/challenges_delete_model.dart';

class ChallengesDeleteRepository extends BaseRepository {
  Future<ChallengesDeleteModel> delete() async {
    // req
    String endpoint = "contents/challenge";
    Response response = await httpClient.deleteRequest(endpoint);

    // result
    ChallengesDeleteModel model = fetchJsonData<ChallengesDeleteModel>(
        response, ChallengesDeleteModel.fromJson);

    return model;
  }
}
