import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members_register/members_register_model.dart';
import 'package:mindsight_admin_page/data/members_register/members_register_req_post.dart';

class MembersRegisterRepository extends BaseRepository {
  Future<MembersRegisterModel> post(MembersRegisterReqPost dto) async {
    // req
    String endpoint = "members";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    MembersRegisterModel model = fetchJsonData<MembersRegisterModel>(
        response, MembersRegisterModel.fromJson);

    return model;
  }
}
