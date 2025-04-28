// import 'package:http/http.dart';
// import 'package:mindsight_admin_page/constants/account_constant.dart';
// import 'package:mindsight_admin_page/data/admin_nouse/admin_signin_nouse/admin_signin_model.dart';
// import 'package:mindsight_admin_page/data/admin_nouse/admin_signin_nouse/admin_signin_req_post.dart';
// import 'package:mindsight_admin_page/data/base_repository.dart';
// import 'package:mindsight_admin_page/utils/logger.dart';
// import 'package:mindsight_admin_page/utils/pref_utils.dart';

// class AdminSigninRepository extends BaseRepository {
//   Future<AdminSigninModel> post(AdminSigninReqPost dto) async {
//     // req
//     String endpoint = "admin/signin";
//     Response response =
//         await httpClient.postRequest(endpoint, body: dto.toJson());

//     // result
//     AdminSigninModel model =
//         fetchJsonData<AdminSigninModel>(response, AdminSigninModel.fromJson);

//     if (model.isSuccess) {
//       httpClient.setBearerAuthorization(model.accessToken!);

//       Account.signInSuccess(model.id!, dto.email!, dto.password!, dto.isThirdParty);
//     } else {

//       Logger.info("log in unsuccessful ${model.getErrorCode()}");
//     }

//     return model;
//   }
// }
