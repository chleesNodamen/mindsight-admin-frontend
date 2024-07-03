import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenges_delete/challenges_delete_model.dart';

class ChallengesDeleteRepository extends BaseRepository {
  Future<ChallengesDeleteModel> delete(Map<String, dynamic> body) async {
    // req
    String endpoint = "contents/challenges";
    Response response = await httpClient.delete(endpoint);

    // result
    ChallengesDeleteModel model = fetchJsonData<ChallengesDeleteModel>(
        response, ChallengesDeleteModel.fromJson);

    return model;
  }
}
