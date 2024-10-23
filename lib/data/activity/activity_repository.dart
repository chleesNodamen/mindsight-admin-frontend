import 'package:mindsight_admin_page/data/activity/activity_model.dart';
import 'package:mindsight_admin_page/data/activity/activity_req_get.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:http/http.dart';

class ActivityRepository extends BaseRepository {
  Future<ActivityModel> get(ActivityReqGet dto) async {
    // req
    String endpoint = "activity";
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    ActivityModel model =
        fetchJsonData<ActivityModel>(response, ActivityModel.fromJson);

    model.length = model.recordId?.length ?? model.length;

    return model;
  }
}
