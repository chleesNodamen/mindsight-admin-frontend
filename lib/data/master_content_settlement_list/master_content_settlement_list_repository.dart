import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_content_settlement_list/master_content_settlement_list_model.dart';
import 'package:mindsight_admin_page/data/master_content_settlement_list/master_content_settlement_list_req_get.dart';

class MasterContentSettlementListRepository extends BaseRepository {
  Future<MasterContentSettlementListModel> get(
      MasterContentSettlementListReqGet dto) async {
    // req
    String endpoint = "settlement/master-content-settlement-list";
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    MasterContentSettlementListModel model =
        fetchJsonData<MasterContentSettlementListModel>(
            response, MasterContentSettlementListModel.fromJson);
    model.length = model.name?.length ?? model.length;

    return model;
  }
}
