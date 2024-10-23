import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/dashboard_challenge/dashboard_challenge_model.dart';
import 'package:mindsight_admin_page/data/dashboard_challenge/dashboard_challenge_req_get.dart';

class DashboardChallengeRepository extends BaseRepository {
  Future<DashboardChallengeModel> get(DashboardChallengeReqGet dto) async {
    // Logger.log(query.toString());

    // req
    String endpoint = "dashboard/challenge";
    // endpoint += addGetParam(query);
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    DashboardChallengeModel model = fetchJsonData<DashboardChallengeModel>(
        response, DashboardChallengeModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}
