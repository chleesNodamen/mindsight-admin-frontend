import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/practice_status/practice_status_req_put.dart';

class PracticeStatusRepository extends BaseRepository {
  Future<BaseModel> put(PracticeStatusReqPut dto) async {
    // req
    String endpoint = "contents/practice-status";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
