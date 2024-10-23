import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/auth/auth_model.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/utils/logger.dart';
import 'package:mindsight_admin_page/utils/pref_utils.dart';

class AuthRepository extends BaseRepository {
  Future<AuthModel> post(AuthReqPost dto) async {
    // req
    String endpoint = "admin/signin";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    AuthModel model = fetchJsonData<AuthModel>(response, AuthModel.fromJson);

    if (model.isSuccess) {
      httpClient.setBearerAuthorization(model.accessToken!);

      PrefUtils.to.setSigninId(dto.email!);
      PrefUtils.to.setSigninTime();
    } else {
      Logger.log("log in unsuccessful");
    }

    return model;
  }
}
