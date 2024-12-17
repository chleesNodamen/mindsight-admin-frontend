import 'package:http/http.dart';
import 'package:mindsight_admin_page/constants/account_constant.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_model.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/utils/logger.dart';
import 'package:mindsight_admin_page/utils/pref_utils_nouse.dart';

class AdminSigninRepository extends BaseRepository {
  Future<AdminSigninModel> post(AdminSigninReqPost dto) async {
    // req
    String endpoint = "admin/signin";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    AdminSigninModel model =
        fetchJsonData<AdminSigninModel>(response, AdminSigninModel.fromJson);

    if (model.isSuccess) {
      httpClient.setBearerAuthorization(model.accessToken!);

      // PrefUtils.to.setSigninId(dto.email!);
      // PrefUtils.to.setSigninTime();

      Account.signInSuccess(model.id!, dto.email!);
    } else {
      Logger.info("log in unsuccessful ${model.getErrorCode()}");
    }

    return model;
  }
}
