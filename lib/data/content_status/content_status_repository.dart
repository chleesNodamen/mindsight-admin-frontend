import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_model.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_req_put.dart';

class ContentStatusRepository extends BaseRepository {
  Future<ContentStatusModel> put(ContentStatusReqPut dto) async {
    // req
    String endpoint = "contents/status";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    ContentStatusModel model = fetchJsonData<ContentStatusModel>(
        response, ContentStatusModel.fromJson);

    return model;
  }
}
