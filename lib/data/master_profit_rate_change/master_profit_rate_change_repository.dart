import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_change/master_profit_rate_change_model.dart';
import 'package:mindsight_admin_page/data/master_profit_rate_change/master_profit_rate_change_req_patch.dart';

class MasterProfitRateChangeRepository extends BaseRepository {
  Future<MasterProfitRateChangeModel> put(
      MasterProfitRateChangeReqPatch dto) async {
    String endpoint = "settlement/master-profit-rate-change";
    Response response =
        await httpClient.patchRequest(endpoint, body: dto.toJson());

    MasterProfitRateChangeModel model =
        fetchJsonData<MasterProfitRateChangeModel>(
            response, MasterProfitRateChangeModel.fromJson);

    return model;
  }
}
