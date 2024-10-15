import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_list/master_profit_rate_list_model.dart';

class MasterProfitRateListRepository extends BaseRepository {
  Future<MasterProfitRateListModel> get(Map<String, dynamic>? query) async {
    // req
    String endpoint = "settlement/master-profit-rate-list";
    // endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint, query: query);

    // result
    MasterProfitRateListModel model = fetchJsonData<MasterProfitRateListModel>(
        response, MasterProfitRateListModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
