import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_register/admin_register_model.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_register/admin_register_req_post.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminRegisterRepository extends BaseRepository {
  Future<AdminRegisterModel> post(AdminRegisterReqPost dto) async {
    // req
    String endpoint = "admin";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    AdminRegisterModel model = fetchJsonData<AdminRegisterModel>(
        response, AdminRegisterModel.fromJson);

    return model;
  }
}
