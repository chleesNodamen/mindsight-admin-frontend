import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_model.dart';

class ContentStatusRepository extends BaseRepository {
  Future<ContentStatusModel> put(Map<String, dynamic> body) async {
    // req
    String endpoint = "contents/status";
    Response response = await httpClient.put(endpoint, body);

    // result
    ContentStatusModel model = fetchJsonData<ContentStatusModel>(
        response, ContentStatusModel.fromJson);

    return model;
  }
}
