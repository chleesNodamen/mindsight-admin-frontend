import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_req_get.dart';

class ContentListRepository extends BaseRepository {
  Future<ContentListModel> get(ContentListReqGet dto) async {
    // if (!Account.isAdmin) {
    //   dto.masterId = Account.id;
    // }

    // req
    String endpoint = "contents";
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    ContentListModel model =
        fetchJsonData<ContentListModel>(response, ContentListModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
