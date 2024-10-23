import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/admin_edit/admin_edit_model.dart';
import 'package:mindsight_admin_page/data/admin_edit/admin_edit_req_put.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminEditRepository extends BaseRepository {
  Future<AdminEditModel> put(String id, AdminEditReqPut dto) async {
    // req
    String endpoint = "admin/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    AdminEditModel model =
        fetchJsonData<AdminEditModel>(response, AdminEditModel.fromJson);

    return model;
  }
}
