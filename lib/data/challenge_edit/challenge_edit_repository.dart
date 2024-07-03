import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenge_edit/challenge_edit_model.dart';

class ChallengeEditRepository extends BaseRepository {
  Future<ChallengeEditModel> put(String? id, Map<String, dynamic> body) async {
    // req
    String endpoint = "contents/challenges/$id";
    Response response = await httpClient.put(endpoint, body);

    // result
    ChallengeEditModel model = fetchJsonData<ChallengeEditModel>(
        response, ChallengeEditModel.fromJson);

    return model;
  }
}
