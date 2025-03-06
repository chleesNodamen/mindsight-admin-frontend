import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_password/admin_password_model.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_password/admin_password_req_put.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminPasswordRepository extends BaseRepository {
  Future<AdminPasswordModel> put(AdminPasswordReqPut dto) async {
    // req
    String endpoint = "admin/password";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    AdminPasswordModel model = fetchJsonData<AdminPasswordModel>(
        response, AdminPasswordModel.fromJson);

    return model;
  }
}
