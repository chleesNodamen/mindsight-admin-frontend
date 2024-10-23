import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/dashboard_practice/dashboard_practice_model.dart';
import 'package:mindsight_admin_page/data/dashboard_practice/dashboard_practice_req_get.dart';

class DashboardPracticeRepository extends BaseRepository {
  Future<DashboardPracticeModel> get(DashboardPracticeReqGet dto) async {
    // Logger.log(query.toString());
    // req
    String endpoint = "dashboard/practice";
    // endpoint += addGetParam(query);
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    DashboardPracticeModel model = fetchJsonData<DashboardPracticeModel>(
        response, DashboardPracticeModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
