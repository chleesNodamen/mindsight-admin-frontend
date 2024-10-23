import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/settlement_summary/settlement_summary_model.dart';
import 'package:mindsight_admin_page/data/settlement_summary/settlement_summary_req_get.dart';

class SettlementSummaryRepository extends BaseRepository {
  Future<SettlementSummaryModel> get(SettlementSummaryReqGet dto) async {
    // req
    String endpoint = "settlement/settlement-summary";
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    SettlementSummaryModel model = fetchJsonData<SettlementSummaryModel>(
        response, SettlementSummaryModel.fromJson);

    return model;
  }
}
