import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_model.dart';
import 'package:mindsight_admin_page/data/content_edit/content_edit_req_put.dart';

class ContentEditRepository extends BaseRepository {
  Future<ContentEditModel> put(String id, ContentEditReqPut dto) async {
    // req
    String endpoint = "contents/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    ContentEditModel model =
        fetchJsonData<ContentEditModel>(response, ContentEditModel.fromJson);

    return model;
  }
}
