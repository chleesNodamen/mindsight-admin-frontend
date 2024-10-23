import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_list/master_profit_rate_list_model.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_list/master_profit_rate_list_req_get.dart';

class MasterProfitRateListRepository extends BaseRepository {
  Future<MasterProfitRateListModel> get(MasterProfitRateListReqGet dto) async {
    // req
    String endpoint = "settlement/master-profit-rate-list";
    // endpoint += addGetParam(query);
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    MasterProfitRateListModel model = fetchJsonData<MasterProfitRateListModel>(
        response, MasterProfitRateListModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
