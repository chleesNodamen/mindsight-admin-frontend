import 'package:http/http.dart';
import 'package:mindsight_admin_page/constants/account_constant.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_model.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/utils/logger.dart';
import 'package:mindsight_admin_page/utils/pref_utils_nouse.dart';

class MasterSigninRepository extends BaseRepository {
  Future<MasterSigninModel> post(MasterSigninReqPost dto) async {
    // req
    String endpoint = "master/signin";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    MasterSigninModel model =
        fetchJsonData<MasterSigninModel>(response, MasterSigninModel.fromJson);

    if (model.isSuccess) {
      httpClient.setBearerAuthorization(model.accessToken!);

      // PrefUtils.to.setSigninId(dto.email!);
      // PrefUtils.to.setSigninTime();

      Account.signinSuccess(model.id!, dto.email!);
    } else {
      Logger.info("master log in unsuccessful ${model.getErrorCode()}");
    }

    return model;
  }
}
