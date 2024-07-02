import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_register/admin_register_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminRegisterRepository extends BaseRepository {
  Future<AdminRegisterModel> put(Map<String, dynamic> body) async {
    // req
    String endpoint = "admin";
    Response response = await httpClient.put(endpoint, body);

    // result
    AdminRegisterModel model = fetchJsonData<AdminRegisterModel>(
        response, AdminRegisterModel.fromJson);

    return model;
  }
}
