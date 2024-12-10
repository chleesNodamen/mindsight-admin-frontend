import 'package:http/http.dart';
import 'package:mindsight_admin_page/constants/account_constant.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/practice_list/practice_list_model.dart';
import 'package:mindsight_admin_page/data/practice_list/practice_list_req_get.dart';

class PracticeListRepository extends BaseRepository {
  Future<PracticeListModel> get(PracticeListReqGet dto) async {
    if (!Account.isAdmin) {
      dto.masterId = Account.id;
    }

    // req
    String endpoint = "contents/practice-list";
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    PracticeListModel model =
        fetchJsonData<PracticeListModel>(response, PracticeListModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}
