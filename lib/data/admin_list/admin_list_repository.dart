import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/admin_list/admin_list_model.dart';
import 'package:mindsight_admin_page/data/admin_list/admin_list_req_get.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminListRepository extends BaseRepository {
  Future<AdminListModel> get(AdminListReqGet dto) async {
    // Logger.log(query.toString());
    // req
    String endpoint = "admin/list";
    // endpoint += addGetParam(query);
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    AdminListModel model =
        fetchJsonData<AdminListModel>(response, AdminListModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
