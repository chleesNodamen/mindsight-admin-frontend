import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_status/content_status_req_put.dart';

class ContentStatusRepository extends BaseRepository {
  Future<BaseModel> put(ContentStatusReqPut dto) async {
    // req
    String endpoint = "contents/status";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
