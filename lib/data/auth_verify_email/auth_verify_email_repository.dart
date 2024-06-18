import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/auth_verify_email/auth_verify_email_model.dart';

class AuthVerifyEmailType {
  static String emailVerification = "emailVerification";
  static String resetPassword = "resetPassword";
}

class AuthVerifyEmailRepository extends BaseRepository {
  Future<AuthVerifyEmailModel> post(Map<String, dynamic> body) async {
    // req
    String endpoint = "auth/verify/email";
    Response response = await httpClient.post(endpoint, body);

    // result
    AuthVerifyEmailModel model = fetchJsonData<AuthVerifyEmailModel>(
        response, AuthVerifyEmailModel.fromJson);

    return model;
  }
}
