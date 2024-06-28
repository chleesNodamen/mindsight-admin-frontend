import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class ActivityDetailsRepository extends BaseRepository {
  Future<ActivityDetailsModel> get(
      String? recordId, Map<String, dynamic>? query) async {
    // req
    String endpoint = "activity/details/$recordId?";
    endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint);

    // result
    ActivityDetailsModel model = fetchJsonData<ActivityDetailsModel>(
        response, ActivityDetailsModel.fromJson);

    return model;
  }
}
