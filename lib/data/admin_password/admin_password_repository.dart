import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_password/admin_password_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminPasswordRepository extends BaseRepository {
  Future<AdminPasswordModel> put(Map<String, dynamic> body) async {
    // req
    String endpoint = "password";
    Response response = await httpClient.put(endpoint, body);

    // result
    AdminPasswordModel model = fetchJsonData<AdminPasswordModel>(
        response, AdminPasswordModel.fromJson);

    return model;
  }
}
