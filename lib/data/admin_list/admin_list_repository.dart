import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_list/admin_list_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminListRepository extends BaseRepository {
  Future<AdminListModel> get(Map<String, dynamic>? query) async {
    Logger.log(query.toString());
    // req
    String endpoint = "list?";
    endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint);

    // result
    AdminListModel model =
        fetchJsonData<AdminListModel>(response, AdminListModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
