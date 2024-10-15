import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_settlement_list/master_settlement_list_model.dart';

class MasterSettlementListRepository extends BaseRepository {
  Future<MasterSettlementListModel> get(Map<String, dynamic>? query) async {
    // req
    String endpoint = "settlement/master-settlement-list";
    // endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint, query: query);

    // result
    MasterSettlementListModel model = fetchJsonData<MasterSettlementListModel>(
        response, MasterSettlementListModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
