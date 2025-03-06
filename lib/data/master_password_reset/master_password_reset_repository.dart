import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_password_reset/master_password_reset_req_post.dart';

class MasterPasswordResetRepository extends BaseRepository {
  Future<BaseModel> put(MasterPasswordResetReqPost dto) async {
    // req
    String endpoint = "master/password-reset";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
