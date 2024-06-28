import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/activity_expert/activity_expert_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class ActivityExpertRepository extends BaseRepository {
  Future<ActivityExpertModel> put(String id, Map<String, dynamic> body) async {
    // req
    String endpoint = "activity/expert/$id";
    Response response = await httpClient.put(endpoint, body);

    // result
    ActivityExpertModel model = fetchJsonData<ActivityExpertModel>(
        response, ActivityExpertModel.fromJson);

    return model;
  }
}
