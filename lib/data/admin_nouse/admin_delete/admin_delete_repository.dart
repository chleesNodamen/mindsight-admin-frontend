import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_delete/admin_delete_model.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_delete/admin_delete_req_delete.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminDeleteRepository extends BaseRepository {
  Future<AdminDeleteModel> delete(AdminDeleteReqDelete dto) async {
    // Logger.log(query.toString());
    // req
    String endpoint = "admin/delete";
    // endpoint += addGetParam(query);
    Response response =
        await httpClient.deleteRequest(endpoint, query: dto.toJson());

    // result
    AdminDeleteModel model =
        fetchJsonData<AdminDeleteModel>(response, AdminDeleteModel.fromJson);

    return model;
  }
}
