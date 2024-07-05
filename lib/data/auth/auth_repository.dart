import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_model.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AuthRepository extends BaseRepository {
  Future<AuthModel> post(AuthReqPost dto) async {
    // req
    String endpoint = "admin/signin";
    Response response = await httpClient.post(endpoint, dto.toJson());
    print(dto.email);
    print(dto.password);
    print(response.body);
    print(response.statusCode);

    // result
    AuthModel model = fetchJsonData<AuthModel>(response, AuthModel.fromJson);

    if (model.isSuccess) {
      httpClient.setBearerAuthorization(model.accessToken!);

      PrefUtils.to.setSigninId(dto.email!);
      PrefUtils.to.setSigninTime();
    } else {
      print("log in unsuccessful"); //TODO
    }

    return model;
  }
}
