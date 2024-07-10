import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_list/content_list_model.dart';

class ContentListRepository extends BaseRepository {
  Future<ContentListModel> get(Map<String, dynamic>? query) async {
    Logger.log(query.toString());
    // req
    String endpoint = "contents?";
    endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint);

    // result
    ContentListModel model =
        fetchJsonData<ContentListModel>(response, ContentListModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
