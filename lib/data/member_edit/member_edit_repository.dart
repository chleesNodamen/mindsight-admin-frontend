import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/member_edit/member_edit_model.dart';
import 'package:mindsight_admin_page/data/member_edit/member_edit_req_put.dart';

class MemberEditRepository extends BaseRepository {
  Future<MemberEditModel> put(String id, MemberEditReqPut dto) async {
    // req
    String endpoint = "member/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    MemberEditModel model =
        fetchJsonData<MemberEditModel>(response, MemberEditModel.fromJson);

    return model;
  }
}
