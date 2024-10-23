import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_settlement_list/master_settlement_list_model.dart';
import 'package:mindsight_admin_page/data/master_settlement_list/master_settlement_list_req_get.dart';

class MasterSettlementListRepository extends BaseRepository {
  Future<MasterSettlementListModel> get(MasterSettlementListReqGet dto) async {
    // req
    String endpoint = "settlement/master-settlement-list";
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    MasterSettlementListModel model = fetchJsonData<MasterSettlementListModel>(
        response, MasterSettlementListModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
