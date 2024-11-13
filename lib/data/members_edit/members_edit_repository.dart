import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members_edit/members_edit_model.dart';
import 'package:mindsight_admin_page/data/members_edit/members_edit_req_put.dart';

class MembersEditRepository extends BaseRepository {
  Future<MembersEditModel> put(String id, MembersEditReqPut dto) async {
    // req
    String endpoint = "members/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    MembersEditModel model =
        fetchJsonData<MembersEditModel>(response, MembersEditModel.fromJson);

    return model;
  }
}
