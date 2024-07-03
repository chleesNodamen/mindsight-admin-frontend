import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenges/challenges_model.dart';

class ChallengesRepository extends BaseRepository {
  Future<ChallengesModel> get(Map<String, dynamic>? query) async {
    Logger.log(query.toString());
    // req
    String endpoint = "contentes/challenges?";
    endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint);

    // result
    ChallengesModel model =
        fetchJsonData<ChallengesModel>(response, ChallengesModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
