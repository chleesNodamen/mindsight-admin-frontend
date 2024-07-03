import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenges_status/challenges_status_model.dart';

class ChallengesStatusRepository extends BaseRepository {
  Future<ChallengesStatusModel> put(Map<String, dynamic> body) async {
    // req
    String endpoint = "contents/challenges/status";
    Response response = await httpClient.put(endpoint, body);

    // result
    ChallengesStatusModel model = fetchJsonData<ChallengesStatusModel>(
        response, ChallengesStatusModel.fromJson);

    return model;
  }
}
