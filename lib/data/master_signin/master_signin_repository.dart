import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_model.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class MasterSigninRepository extends BaseRepository {
  Future<MasterSigninModel> post(MasterSigninReqPost dto) async {
    dto.version = AppConstant.version;

    // req
    String endpoint = "master/signin";
    http.Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    MasterSigninModel model =
        fetchJsonData<MasterSigninModel>(response, MasterSigninModel.fromJson);

    if (model.isSuccess) {
      httpClient.setBearerAuthorization(model.accessToken!);
      Account.signInSuccess(model.id!, dto.email!);

      setSideMenuItemRoutes();
    } else {
      Logger.info("master log in unsuccessful ${model.getErrorCode()}");
    }

    return model;
  }
}
