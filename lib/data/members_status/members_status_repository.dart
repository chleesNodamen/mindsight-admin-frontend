import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members_status/members_status_model.dart';
import 'package:mindsight_admin_page/data/members_status/members_status_req_put.dart';

class MembersStatusRepository extends BaseRepository {
  Future<MembersStatusModel> put(MembersStatusReqPut dto) async {
    // req
    String endpoint = "members/status";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    MembersStatusModel model = fetchJsonData<MembersStatusModel>(
        response, MembersStatusModel.fromJson);

    return model;
  }
}
