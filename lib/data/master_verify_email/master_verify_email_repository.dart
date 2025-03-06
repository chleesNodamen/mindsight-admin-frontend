import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_verify_email/master_verify_email_req_post.dart';

class MasterVerifyEmailRepository extends BaseRepository {
  static String register = "REGISTER";
  static String resetPassword = "RESET_PASSWORD";

  Future<BaseModel> post(MasterVerifyEmailReqPost dto) async {
    String endpoint = "master/verify/email";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);
    return model;
  }
}
