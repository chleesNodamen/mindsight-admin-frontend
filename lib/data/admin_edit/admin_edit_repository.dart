import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_edit/admin_edit_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminEditRepository extends BaseRepository {
  Future<AdminEditModel> put(String id, Map<String, dynamic> body) async {
    // req
    String endpoint = "admin/$id";
    Response response = await httpClient.put(endpoint, body);

    // result
    AdminEditModel model =
        fetchJsonData<AdminEditModel>(response, AdminEditModel.fromJson);

    return model;
  }
}
