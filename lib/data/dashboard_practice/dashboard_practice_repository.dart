import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/dashboard_practice/dashboard_practice_model.dart';

class DashboardPracticeRepository extends BaseRepository {
  Future<DashboardPracticeModel> get(Map<String, dynamic>? query) async {
    Logger.log(query.toString());
    // req
    String endpoint = "dashboard/practice";
    endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint);

    // result
    DashboardPracticeModel model =
        fetchJsonData<DashboardPracticeModel>(response, DashboardPracticeModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
