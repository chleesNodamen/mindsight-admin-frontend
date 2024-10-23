import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/dashboard_registered/dashboard_registered_model.dart';

class DashboardRegisteredRepository extends BaseRepository {
  Future<DashboardRegisteredModel> get() async {
    // req
    String endpoint = "dashboard/registered";
    Response response = await httpClient.getRequest(endpoint);

    // result
    DashboardRegisteredModel model = fetchJsonData<DashboardRegisteredModel>(
        response, DashboardRegisteredModel.fromJson);

    return model;
  }
}
