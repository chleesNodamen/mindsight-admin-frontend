import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/purchase_list/purchase_list_model.dart';
import 'package:mindsight_admin_page/data/purchase_list/purchase_list_req_get.dart';

class PurchaseListRepository extends BaseRepository {
  Future<PurchaseListModel> get(PurchaseListReqGet dto) async {
    // req
    String endpoint = "settlement/purchase-list";
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    PurchaseListModel model =
        fetchJsonData<PurchaseListModel>(response, PurchaseListModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
