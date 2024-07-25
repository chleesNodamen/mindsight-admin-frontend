import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_delete/content_delete_model.dart';

class ContentDeleteRepository extends BaseRepository {
  Future<ContentDeleteModel> delete(String? id) async {
    // req
    String endpoint = "contents/$id";
    Response response = await httpClient.delete(endpoint);

    // result
    ContentDeleteModel model = fetchJsonData<ContentDeleteModel>(
        response, ContentDeleteModel.fromJson);

    return model;
  }
}
