import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/constants/account_constant.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_list/master_list_model.dart';
import 'package:mindsight_admin_page/data/master_list/master_list_req_get.dart';

class MasterListRepository extends BaseRepository {
  Future<MasterListModel> get(MasterListReqGet dto) async {
    if (!Account.isAdmin) {
      dto.masterId = Account.id;
    }
    // req
    String endpoint = "master";
    http.Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    MasterListModel model =
        fetchJsonData<MasterListModel>(response, MasterListModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}
