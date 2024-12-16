import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/member_delete/member_status_req_put.dart';

class MemberDeleteRepository extends BaseRepository {
  Future<BaseModel> put(MemberDeleteReqPut dto) async {
    // req
    String endpoint = "member/delete";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
