import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/activity/activity_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class ActivityRepository extends BaseRepository {
  Future<ActivityModel> get(Map<String, dynamic>? query) async {
    Logger.log(query.toString());

    // req
    String endpoint = "activity?";
    endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint);

    // result
    ActivityModel model =
        fetchJsonData<ActivityModel>(response, ActivityModel.fromJson);

    model.length = model.recordId?.length ?? model.length;

    return model;
  }
}
