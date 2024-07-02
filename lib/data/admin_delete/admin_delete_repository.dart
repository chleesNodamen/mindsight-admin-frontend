import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_delete/admin_delete_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminDeleteRepository extends BaseRepository {
  Future<AdminDeleteModel> delete(Map<String, dynamic> query) async {
    Logger.log(query.toString());
    // req
    String endpoint = "admin/delete?";
    Response response = await httpClient.put(endpoint, query);

    // result
    AdminDeleteModel model =
        fetchJsonData<AdminDeleteModel>(response, AdminDeleteModel.fromJson);

    return model;
  }
}
