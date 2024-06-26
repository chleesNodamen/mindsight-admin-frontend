import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/dashboard_challenge/dashboard_challenge_model.dart';

class DashboardChallengeRepository extends BaseRepository {
  Future<DashboardChallengeModel> get(Map<String, dynamic>? query) async {
    Logger.log(query.toString());

    // req
    String endpoint = "dashboard/challenge?";
    endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint);

    // result
    DashboardChallengeModel model = fetchJsonData<DashboardChallengeModel>(
        response, DashboardChallengeModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}
