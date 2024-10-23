import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/activity_expert/activity_expert_model.dart';
import 'package:mindsight_admin_page/data/activity_expert/activity_expert_req_put.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class ActivityExpertRepository extends BaseRepository {
  Future<ActivityExpertModel> put(String id, ActivityExpertReqPut dto) async {
    // req
    String endpoint = "activity/expert/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    ActivityExpertModel model = fetchJsonData<ActivityExpertModel>(
        response, ActivityExpertModel.fromJson);

    return model;
  }
}
