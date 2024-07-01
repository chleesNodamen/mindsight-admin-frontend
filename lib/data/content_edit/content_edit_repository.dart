import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_model.dart';

class ContentEditRepository extends BaseRepository {
  Future<ContentEditModel> put(String id, Map<String, dynamic> body) async {
    // req
    String endpoint = "contents/$id";
    Response response = await httpClient.put(endpoint, body);

    // result
    ContentEditModel model =
        fetchJsonData<ContentEditModel>(response, ContentEditModel.fromJson);

    return model;
  }
}
