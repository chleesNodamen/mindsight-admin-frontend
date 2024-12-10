import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/practice_edit/practice_edit_req_put.dart';

class PracticeEditRepository extends BaseRepository {
  Future<BaseModel> put(String? id, PracticeEditReqPut dto) async {
    // req
    String endpoint = "contents/practice/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
