import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_model.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_req_get.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class ActivityDetailsRepository extends BaseRepository {
  Future<ActivityDetailsModel> get(
      String? recordId, ActivityDetailsReqGet dto) async {
    // req
    // String endpoint = "activity/details/$recordId?";
    // endpoint += addGetParam(query);
    // Response response = await httpClient.getRequest(endpoint);

    String endpoint = "activity/details/$recordId";
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    ActivityDetailsModel model = fetchJsonData<ActivityDetailsModel>(
        response, ActivityDetailsModel.fromJson);

    return model;
  }
}
